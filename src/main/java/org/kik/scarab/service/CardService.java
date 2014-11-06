package org.kik.scarab.service;

import java.util.List;
import java.util.UUID;

import org.kik.scarab.model.document.Card;
import org.kik.scarab.model.document.Product;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class CardService {

	private static final Logger LOG = LoggerFactory
			.getLogger(CardService.class);

	@Autowired
	private MongoTemplate mongoTemplate;

	@Autowired
	private ProductService productSvc;

	public static final String COLLECTION_NAME = "card";

	public void addCard(Card card) {
		if (!mongoTemplate.collectionExists(Card.class)) {
			mongoTemplate.createCollection(Card.class);
		}

		card.setId(UUID.randomUUID().toString());

		if (card.getProduct() != null && card.getProduct().getId() != null) {
			LOG.info("add card for product {}", card.getProduct().getId());
			Product p = productSvc.getProductById(card.getProduct().getId());
			LOG.info("add card for product {}", p.getName());
//			card.setProduct(p);
		}

		mongoTemplate.insert(card, COLLECTION_NAME);
	}

	public List<Card> getAllCards() {
		return mongoTemplate.findAll(Card.class, COLLECTION_NAME);
	}

}