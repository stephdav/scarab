package org.kik.scarab.service;

import java.util.List;

import org.kik.scarab.dao.UserStoryDao;
import org.kik.scarab.model.UserStory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserStoryService {

	@Autowired
	private UserStoryDao dao;

	public UserStoryService() {
		// Empty constructor
	}

	/**
	 * Constructor for Unit Testing
	 * 
	 * @param dao
	 */
	public UserStoryService(UserStoryDao dao) {
		this.dao = dao;
	}

	public UserStory createUserStory(UserStory us) {
		return dao.createUserStory(us);
	}

	public void deleteUserStory(String id) {
		dao.deleteUserStory(id);
	}

	public List<UserStory> getUserStories() {
		return dao.findAllUserStories();
	}
}
