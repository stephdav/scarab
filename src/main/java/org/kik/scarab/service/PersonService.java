package org.kik.scarab.service;

import java.util.List;
import java.util.UUID;

import org.kik.scarab.model.document.Person;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class PersonService {

	@Autowired
	private MongoTemplate mongoTemplate;

	public static final String COLLECTION_NAME = "person";

	public void addPerson(Person person) {
		if (!mongoTemplate.collectionExists(Person.class)) {
			mongoTemplate.createCollection(Person.class);
		}
		person.setId(UUID.randomUUID().toString());
		mongoTemplate.insert(person, COLLECTION_NAME);
	}

	public List<Person> listPerson() {
		return mongoTemplate.findAll(Person.class, COLLECTION_NAME);
	}

	public void deletePerson(Person person) {
		mongoTemplate.remove(person, COLLECTION_NAME);
	}

	public void updatePerson(Person person) {
		mongoTemplate.insert(person, COLLECTION_NAME);
	}
}