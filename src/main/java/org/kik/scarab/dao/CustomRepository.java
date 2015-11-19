package org.kik.scarab.dao;

import java.util.List;

import org.kik.scarab.model.dashboard.DoughnutData;

public interface CustomRepository {
	List<DoughnutData> getCycleTimeData(long projectId);

	List<DoughnutData> getTasksPerCategory(long projectId);

	List<DoughnutData> getTasksPerStatus(long projectId);

	List<DoughnutData> getTasksPerUser(long projectId);
}
