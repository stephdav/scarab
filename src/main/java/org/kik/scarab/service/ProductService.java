package org.kik.scarab.service;

import java.util.List;
import java.util.UUID;

import org.kik.scarab.model.document.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class ProductService {

	@Autowired
	private MongoTemplate mongoTemplate;

	public static final String COLLECTION_NAME = "product";

	public Product addProduct(Product product) {
		if (!mongoTemplate.collectionExists(Product.class)) {
			mongoTemplate.createCollection(Product.class);
		}
		product.setId(UUID.randomUUID().toString());
		mongoTemplate.insert(product, COLLECTION_NAME);
		return product;
	}

	public Product updateProduct(Product product) {
		// TODO update product
		return null;
	}

	public void deleteProduct(String id) {
		Product product = new Product();
		product.setId(id);
		mongoTemplate.remove(product, COLLECTION_NAME);
	}

	public Product getProductById(String id) {
		return mongoTemplate.findById(id, Product.class, COLLECTION_NAME);
	}

	public List<Product> getAllProducts() {
		return mongoTemplate.findAll(Product.class, COLLECTION_NAME);
	}

}