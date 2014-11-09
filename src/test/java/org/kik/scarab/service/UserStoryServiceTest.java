package org.kik.scarab.service;

import java.util.Arrays;
import java.util.List;

import org.easymock.EasyMock;
import org.easymock.Mock;
import org.junit.Assert;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import org.kik.scarab.dao.UserStoryDao;
import org.kik.scarab.model.UserStory;

public class UserStoryServiceTest {

	private UserStoryService svc;

	@Mock
	private UserStoryDao mock;

	private static UserStory US1;
	private static UserStory US2;
	private static List<UserStory> ALL_US;

	@BeforeClass
	public static void initData() {
		US1 = new UserStory();
		US1.setId("123");
		US1.setTitle("title1");
		US1.setDescription("desc1");

		US2 = new UserStory();
		US2.setId("456");
		US2.setTitle("title2");
		US2.setDescription("desc2");

		ALL_US = Arrays.asList(new UserStory[] { US1, US2 });
	}

	@Before
	public void setUp() {
		mock = EasyMock.createMock(UserStoryDao.class);

		mock.createUserStory(EasyMock.anyObject(UserStory.class));
		EasyMock.expectLastCall().andReturn(US1);

		mock.findAllUserStories();
		EasyMock.expectLastCall().andReturn(ALL_US);

		svc = new UserStoryService(mock);
	}

	@Test
	public void testCreateUserStory() {
		// init
		UserStory input = new UserStory();
		input.setTitle("title");
		input.setDescription("desc");

		// test
		EasyMock.replay(mock);
		UserStory output = svc.createUserStory(input);

		// assertions
		Assert.assertEquals("123", output.getId());
		Assert.assertEquals("title1", output.getTitle());
		Assert.assertEquals("desc1", output.getDescription());
	}

	@Test
	public void testGetUserStories() {
		// init
		
		// test
		EasyMock.replay(mock);
		List<UserStory> output = svc.getUserStories();

		// assertions
		Assert.assertNotNull(output);
		Assert.assertEquals(2, output.size());
		Assert.assertEquals("123", output.get(0).getId());
		Assert.assertEquals("456", output.get(1).getId());
	}
}
