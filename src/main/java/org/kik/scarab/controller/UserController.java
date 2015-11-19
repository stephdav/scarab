package org.kik.scarab.controller;

import java.util.List;

import org.kik.scarab.model.User;
import org.kik.scarab.service.UserService;
import org.kik.scarab.service.exception.FunctionalException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/users")
public class UserController {

	private static final Logger LOGGER = LoggerFactory
			.getLogger(UserController.class);

	@Autowired
	private UserService userSvc;

	public UserController() {
		// Empty constructor
	}

	public UserController(UserService userSvc) {
		this.userSvc = userSvc;
	}

	/**
	 * GET the list of all users.
	 * 
	 * @return a list of {@link User}
	 */
	@RequestMapping(value = "", method = RequestMethod.GET)
	public ResponseEntity<List<User>> getUsers() {
		LOGGER.info("[API] GET users");
		return new ResponseEntity<List<User>>(userSvc.getList(), HttpStatus.OK);
	}

	@RequestMapping(value = "", method = RequestMethod.POST)
	public @ResponseBody ResponseEntity<String> createUser(@RequestBody User usr) {
		LOGGER.info("[API] POST a new user");
		HttpStatus status = HttpStatus.CREATED;
		try {
			userSvc.save(usr);
		} catch (FunctionalException e) {
			status = HttpStatus.CONFLICT;
			LOGGER.error("can not create user");
		}
		return new ResponseEntity<String>(status);
	}

	@RequestMapping(value = "/{userId}", method = RequestMethod.DELETE)
	public ResponseEntity<String> deleteUser(@PathVariable String userId) {
		LOGGER.info("[API] DELETE user " + userId);
		HttpStatus status = HttpStatus.NO_CONTENT;
		userSvc.deleteUser(Long.valueOf(userId));
		return new ResponseEntity<String>(status);
	}
}
