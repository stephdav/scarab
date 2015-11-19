package org.kik.scarab.dao;

import java.util.List;

import org.kik.scarab.model.CycleTime;

public interface CycleTimeRepository extends BaseRepository<CycleTime, Long> {

	CycleTime findFirstByTaskIdAndStatusId(long taskId, long statusId);

	List<CycleTime> findByTaskProjectId(long projectId);

	void deleteByTaskId(long taskId);

	void deleteByTaskProjectId(long projectId);
}
