package org.kik.scarab.model.dashboard;

import java.util.List;

public class Bar {

	private List<String> labels;
	private List<Dataset> datasets;

	public Bar() {
		// Empty constructor
	}

	public Bar(List<String> labels, List<Dataset> datasets) {
		this.labels = labels;
		this.datasets = datasets;
	}

	public List<String> getLabels() {
		return labels;
	}

	public void setLabels(List<String> labels) {
		this.labels = labels;
	}

	public List<Dataset> getDatasets() {
		return datasets;
	}

	public void setDatasets(List<Dataset> datasets) {
		this.datasets = datasets;
	}

}
