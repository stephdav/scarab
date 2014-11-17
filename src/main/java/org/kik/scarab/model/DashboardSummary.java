package org.kik.scarab.model;

import org.codehaus.jackson.map.annotate.JsonSerialize;

@JsonSerialize(include = JsonSerialize.Inclusion.NON_NULL)
public class DashboardSummary {

	private long usCount;
	private long teamCount;

	public DashboardSummary() {
		// Empty constructor
	}

	public long getUsCount() {
		return usCount;
	}

	public void setUsCount(long usCount) {
		this.usCount = usCount;
	}

	public long getTeamCount() {
		return teamCount;
	}

	public void setTeamCount(long teamCount) {
		this.teamCount = teamCount;
	}
}
