package org.kik.scarab.service;

import java.util.List;
import java.util.UUID;

import org.kik.scarab.model.document.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class UserService {

	@Autowired
	private MongoTemplate mongoTemplate;

	public static final String COLLECTION_NAME = "users";

	public void addUser(User usr) {
		if (!mongoTemplate.collectionExists(User.class)) {
			mongoTemplate.createCollection(User.class);
		}
		usr.setId(UUID.randomUUID().toString());
		mongoTemplate.insert(usr, COLLECTION_NAME);
	}

	public List<User> getAllUsers() {
		return mongoTemplate.findAll(User.class, COLLECTION_NAME);
	}

}