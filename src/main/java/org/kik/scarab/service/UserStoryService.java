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
	public UserStoryService(final UserStoryDao dao) {
		this.dao = dao;
	}

	public UserStory createUserStory(final UserStory us) {
		return dao.createUserStory(us);
	}

	public UserStory getUserStory(String id) {
		return dao.getUserStory(id);
	}

	public UserStory updateUserStory(final UserStory us) {
		return dao.updateUserStory(us);
	}

	public void deleteUserStory(String id) {
		dao.deleteUserStory(id);
	}

	public List<UserStory> getUserStories() {
		return dao.findAllUserStories();
	}

	public List<UserStory> getSortedUserStories(final String sortBy,
			final String sortDir) {
		return dao.findAllUserStoriesSorted(sortBy, sortDir);
	}
	
	public List<UserStory> findUserStoriesWithEstimate(int estimate) {
		return dao.findUserStoriesWithEstimate(estimate);
	}

}
