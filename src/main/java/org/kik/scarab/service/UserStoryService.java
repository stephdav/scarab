package org.kik.scarab.service;

import org.kik.scarab.dao.UserStoryDao;
import org.kik.scarab.model.UserStory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserStoryService {

	@Autowired
	private UserStoryDao dao;

	public UserStory createUserStory(UserStory us) {
		return dao.createUserStory(us);
	}

}
