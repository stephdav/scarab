package org.kik.scarab.model.dashboard;

import java.util.List;

public class Dataset {

	private String label;
	private String fillColor;
	private String strokeColor;
	private String highlightFill;
	private String highlightStroke;
	private List<Long> data;

	public Dataset() {
		// Empty constructor
	}

	public Dataset(String label, String color, List<Long> data) {
		this.label = label;
		this.fillColor = String.format("rgba(%s,0.5)", color);
		this.strokeColor = String.format("rgba(%s,0.8)", color);
		this.highlightFill = String.format("rgba(%s,0.75)", color);
		this.highlightStroke = String.format("rgba(%s,1)", color);
		this.data = data;
	}

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public String getFillColor() {
		return fillColor;
	}

	public void setFillColor(String fillColor) {
		this.fillColor = fillColor;
	}

	public String getStrokeColor() {
		return strokeColor;
	}

	public void setStrokeColor(String strokeColor) {
		this.strokeColor = strokeColor;
	}

	public String getHighlightFill() {
		return highlightFill;
	}

	public void setHighlightFill(String highlightFill) {
		this.highlightFill = highlightFill;
	}

	public String getHighlightStroke() {
		return highlightStroke;
	}

	public void setHighlightStroke(String highlightStroke) {
		this.highlightStroke = highlightStroke;
	}

	public List<Long> getData() {
		return data;
	}

	public void setData(List<Long> data) {
		this.data = data;
	}

}
