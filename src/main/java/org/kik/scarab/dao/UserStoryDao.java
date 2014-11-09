package org.kik.scarab.dao;

import java.util.UUID;

import org.kik.scarab.model.UserStory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Service;

@Service
public class UserStoryDao {

	@Autowired
	private MongoTemplate mongoTemplate;

	public UserStory createUserStory(UserStory us) {
		if (!mongoTemplate.collectionExists(UserStory.class)) {
			mongoTemplate.createCollection(UserStory.class);
		}
		us.setId(UUID.randomUUID().toString());
		mongoTemplate.insert(us);
		return us;
	}

}
