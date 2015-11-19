package org.kik.scarab.controller;

import org.junit.Before;
import org.junit.runner.RunWith;
import org.kik.scarab.service.ProjectService;
import org.mockito.Mock;
import org.mockito.runners.MockitoJUnitRunner;

@RunWith(MockitoJUnitRunner.class)
public class ProjectControllerTest {

	@Mock
	private ProjectService userService;

	private ProjectController userController;

	@Before
	public void setUp() {
		userController = new ProjectController(userService);
	}

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