package org.kik.scarab.model.dashboard;

public class DoughnutData {

	private String label;

	private long total;

	public DoughnutData() {
		// Empty constructor
	}

	public String getLabel() {
		return label;
	}

	public void setLabel(String status) {
		this.label = status;
	}

	public long getTotal() {
		return total;
	}

	public void setTotal(long total) {
		this.total = total;
	}
}
