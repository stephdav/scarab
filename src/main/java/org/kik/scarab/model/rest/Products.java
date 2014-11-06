package org.kik.scarab.model.rest;

import java.util.ArrayList;
import java.util.List;

import org.kik.scarab.model.document.Product;

public class Products {

	private List<Product> products;

	public Products() {
		// Empty constructor
	}

	public List<Product> getProducts() {
		if (products == null) {
			products = new ArrayList<Product>();
		}
		return products;
	}

	public void setProducts(List<Product> products) {
		this.products = products;
	}
}
