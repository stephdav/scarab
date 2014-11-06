package org.kik.scarab.controller;

import java.util.List;

import org.kik.scarab.model.document.Card;
import org.kik.scarab.model.document.Product;
import org.kik.scarab.model.rest.Cards;
import org.kik.scarab.model.rest.JSONResult;
import org.kik.scarab.service.CardService;
import org.kik.scarab.service.ProductService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/rest")
public class RestController {

	private static final Logger LOG = LoggerFactory
			.getLogger(RestController.class);

	@Autowired
	private ProductService productSvc;

	@Autowired
	private CardService cardSvc;

	@RequestMapping(value = "/products", method = RequestMethod.GET)
	public @ResponseBody
	List<Product> getProducts() {
		LOG.info("getProducts()");
		List<Product> products = productSvc.getAllProducts();
		LOG.info("getProducts() : {}", products.size());
		return products;
	}

	@RequestMapping(value = "/product", method = RequestMethod.POST)
	public @ResponseBody
	Product saveProduct(@RequestBody Product product) {
		return productSvc.addProduct(product);
	}

	@RequestMapping(value = "/product/{id}", method = RequestMethod.PUT)
	public @ResponseBody
	Product updateProduct(@PathVariable String id, @RequestBody Product product) {
		return productSvc.updateProduct(product);
	}

	@RequestMapping(value = "/product/{id}", method = RequestMethod.DELETE)
	public @ResponseBody
	void deleteProduct(@PathVariable String id) {
		LOG.info("delete product {}", id);
		productSvc.deleteProduct(id);
	}

	@RequestMapping(value = "/card/save", method = RequestMethod.POST)
	public @ResponseBody
	JSONResult saveCard(@RequestBody Card card) {
		JSONResult result = new JSONResult();
		cardSvc.addCard(card);
		result.setStatus("ADDED");
		return result;
	}

	@RequestMapping(value = "/cards", method = RequestMethod.GET)
	public @ResponseBody
	Cards getCards() {
		Cards liste = new Cards();
		liste.setCards(cardSvc.getAllCards());
		return liste;
	}
}