package org.kik.scarab.model.rest;

import java.util.ArrayList;
import java.util.List;

import org.kik.scarab.model.document.Card;

public class Cards {

	private List<Card> cards;

	public Cards() {
		// Empty constructor
	}

	public List<Card> getCards() {
		if (cards == null) {
			cards = new ArrayList<Card>();
		}
		return cards;
	}

	public void setCards(List<Card> cards) {
		this.cards = cards;
	}
}
