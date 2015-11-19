package org.kik.scarab.model.dashboard;

public class Doughnut {

	private long value;
	private String color;
	private String highlight;
	private String label;

	public Doughnut() {
		// Empty constructor
	}

	public Doughnut(long value, String color, String highlight, String label) {
		this.value = value;
		this.color = color;
		this.highlight = highlight;
		this.label = label;
	}

	public long getValue() {
		return value;
	}

	public void setValue(long value) {
		this.value = value;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public String getHighlight() {
		return highlight;
	}

	public void setHighlight(String highlight) {
		this.highlight = highlight;
	}

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

}
