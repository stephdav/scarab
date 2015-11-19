package org.kik.scarab.service;

import org.junit.Before;
import org.junit.runner.RunWith;
import org.kik.scarab.dao.ProjectRepository;
import org.mockito.Mock;
import org.mockito.runners.MockitoJUnitRunner;

@RunWith(MockitoJUnitRunner.class)
public class ProjectServiceImplTest {

	@Mock
	private ProjectRepository userRepository;

	private ProjectService userService;

	@Before
	public void setUp() {
		userService = new ProjectServiceImpl(userRepository);
	}

	// @Test
	// public void shouldSaveNewUser() {
	// final User savedUser = stubRepositoryToReturnUserOnSave();
	// final User user = new User();
	// final User returnedUser = userService.save(user);
	// // verify repository was called with user
	// verify(userRepository, times(1)).save(user);
	// assertEquals("Returned user should come from the repository",
	// savedUser, returnedUser);
	// }
	//
	// private User stubRepositoryToReturnUserOnSave() {
	// final User user = JDDUtil.createUser();
	// when(userRepository.save(any(User.class))).thenReturn(user);
	// return user;
	// }

}
