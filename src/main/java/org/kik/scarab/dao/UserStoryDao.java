package org.kik.scarab.dao;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.kik.scarab.model.UserStory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.BasicQuery;
import org.springframework.data.mongodb.core.query.Query;
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
		us.setCreationDate(new Date());
		us.setModificationDate(new Date());
		mongoTemplate.insert(us);
		return us;
	}

	public List<UserStory> findAllUserStories() {
		return mongoTemplate.findAll(UserStory.class);
	}

	public List<UserStory> findAllUserStoriesSorted(final String dir) {
		Query query = new Query();
		if ("ASC".equals(dir)) {
			query.with(new Sort(Sort.Direction.ASC, "code"));
			query.with(new Sort(Sort.Direction.ASC, "title"));
		} else {
			query.with(new Sort(Sort.Direction.DESC, "code"));
			query.with(new Sort(Sort.Direction.DESC, "title"));
		}
		return mongoTemplate.find(query, UserStory.class);
	}

	public long getUserStoryCount() {
		return mongoTemplate.count(null, UserStory.class);
	}

	public UserStory getUserStory(String id) {
		BasicQuery query = new BasicQuery("{ id : '" + id + "' }");
		return mongoTemplate.findOne(query, UserStory.class);
	}

	public UserStory updateUserStory(UserStory us) {
		us.setModificationDate(new Date());
		mongoTemplate.save(us);
		return us;
	}

	public void deleteUserStory(String id) {
		BasicQuery query = new BasicQuery("{ id : '" + id + "' }");
		mongoTemplate.remove(query, UserStory.class);
	}
}
