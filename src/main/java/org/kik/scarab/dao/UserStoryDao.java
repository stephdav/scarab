package org.kik.scarab.dao;

import java.util.List;
import java.util.UUID;

import org.kik.scarab.model.UserStory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.BasicQuery;
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

	public List<UserStory> findAllUserStories() {
		return mongoTemplate.findAll(UserStory.class);
	}

	public UserStory getUserStory(String id) {
		BasicQuery query = new BasicQuery("{ id : '" + id + "' }");
		return mongoTemplate.findOne(query, UserStory.class);
	}

	public UserStory updateUserStory(UserStory us) {
		mongoTemplate.save(us);
		return us;
	}

	public void deleteUserStory(String id) {
		BasicQuery query = new BasicQuery("{ id : '" + id + "' }");
		mongoTemplate.remove(query, UserStory.class);
	}
}
