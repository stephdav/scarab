package org.kik.scarab.service;

import static org.junit.Assert.assertEquals;
import static org.mockito.Matchers.any;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.kik.scarab.dao.UserRepository;
import org.kik.scarab.model.User;
import org.kik.scarab.service.exception.FunctionalException;
import org.kik.scarab.util.JDDUtil;
import org.mockito.Mock;
import org.mockito.runners.MockitoJUnitRunner;

@RunWith(MockitoJUnitRunner.class)
public class UserServiceImplTest {

	@Mock
	private UserRepository userRepository;

	private UserService userService;

	@Before
	public void setUp() {
		userService = new UserServiceImpl(userRepository);
	}

	@Test
	public void shouldSaveNewUser() throws FunctionalException {
		final User savedUser = stubRepositoryToReturnUserOnSave();
		final User user = new User();
		final User returnedUser = userService.save(user);
		// verify repository was called with user
		verify(userRepository, times(1)).save(user);
		assertEquals("Returned user should come from the repository",
				savedUser, returnedUser);
	}

	private User stubRepositoryToReturnUserOnSave() {
		final User user = JDDUtil.createUser();
		when(userRepository.save(any(User.class))).thenReturn(user);
		return user;
	}
	// TODO
	// @Test
	// public void
	// shouldSaveNewUser_GivenThereExistsOneWithTheSameId_ThenTheExceptionShouldBeThrown()
	// throws Exception {
	// stubRepositoryToReturnExistingUser();
	// try {
	// userService.save(JDDUtil.createUser());
	// fail("Expected exception");
	// } catch (UserAlreadyExistsException ignored) {
	// }
	// verify(userRepository, never()).save(any(User.class));
	// }
	//
	// private void stubRepositoryToReturnExistingUser() {
	// final User user = JDDUtil.createUser();
	// when(userRepository.findOne(user.getId())).thenReturn(user);
	// }

}
