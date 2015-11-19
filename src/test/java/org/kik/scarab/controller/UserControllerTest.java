package org.kik.scarab.controller;

import org.junit.Before;
import org.junit.runner.RunWith;
import org.kik.scarab.service.UserService;
import org.mockito.Mock;
import org.mockito.runners.MockitoJUnitRunner;

@RunWith(MockitoJUnitRunner.class)
public class UserControllerTest {

	@Mock
	private UserService userService;

	private UserController userController;

	@Before
	public void setUp() {
		userController = new UserController(userService);
	}

	// TODO
	// @Test
	// public void shouldCreateUser() throws Exception {
	// final User savedUser = stubServiceToReturnStoredUser();
	// final User user = new User();
	// User returnedUser = userController.createUser(user);
	// // verify user was passed to UserService
	// verify(userService, times(1)).save(user);
	// assertEquals("Returned user should come from the service", savedUser,
	// returnedUser);
	// }
	//
	// private User stubServiceToReturnStoredUser() {
	// final User user = new User();
	// when(userService.save(any(User.class))).thenReturn(user);
	// return user;
	// }

}