package org.kik.scarab.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

import org.kik.scarab.dao.UserRepository;
import org.kik.scarab.model.User;
import org.kik.scarab.service.exception.FunctionalException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UserServiceImpl implements UserService {

	private static final Logger LOGGER = LoggerFactory
			.getLogger(UserServiceImpl.class);

	@Autowired
	private UserRepository repository;

	public UserServiceImpl() {
		// Empty constructor
	}

	public UserServiceImpl(final UserRepository repository) {
		this.repository = repository;
	}

	@Override
	@Transactional
	public User save(final User user) throws FunctionalException {
		User existing = repository.findFirstByUsername(user.getUsername());
		if (existing != null) {
			throw new FunctionalException(String.format(
					"There already exists a user with username=%s",
					user.getUsername()));
		}
		return repository.save(user);
	}

	@Override
	@Transactional(readOnly = true)
	public List<User> getList() {
		LOGGER.debug("Retrieving the list of all users");
		List<User> users = repository.findAll();
		for (User user : users) {
			user.setPassword(null);
		}
		return users;
	}

	@Override
	public void deleteUser(long id) {
		Optional<User> opt = repository.findOne(id);
		if (opt.isPresent()) {
			repository.delete(opt.get());
		}
	}

	@Override
	public List<String> getUsernames() {
		List<String> usernames = new ArrayList<>();
		List<User> users = repository.findAll();
		if (users != null) {
			for (User user : users) {
				usernames.add(user.getUsername());
			}
		}
		Collections.sort(usernames);
		return usernames;
	}
}
