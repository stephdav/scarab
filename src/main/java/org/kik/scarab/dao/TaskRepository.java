package org.kik.scarab.dao;

import java.util.List;

import org.kik.scarab.model.Task;

public interface TaskRepository extends BaseRepository<Task, Long> {
	List<Task> findByProjectId(long projectId);

	void deleteByProjectId(long projectId);
}
