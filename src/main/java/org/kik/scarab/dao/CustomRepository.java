package org.kik.scarab.dao;

import java.util.List;

import org.kik.scarab.model.dashboard.ChartData;

public interface CustomRepository {
	List<ChartData> getCycleTimeData(long projectId);

	List<ChartData> getTasksPerCategory(long projectId);

	List<ChartData> getTasksPerStatus(long projectId);

	List<ChartData> getTasksPerUser(long projectId);
}
