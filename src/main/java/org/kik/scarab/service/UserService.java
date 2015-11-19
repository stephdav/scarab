package org.kik.scarab.service;

import java.util.List;

import org.kik.scarab.model.User;
import org.kik.scarab.service.exception.FunctionalException;

public interface UserService {

	User save(User user) throws FunctionalException;

	List<User> getList();

	void deleteUser(long id);

	List<String> getUsernames();
}
