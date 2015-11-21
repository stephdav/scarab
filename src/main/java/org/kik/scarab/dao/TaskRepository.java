package org.kik.scarab.dao;

import java.util.List;

import org.kik.scarab.model.Task;

public interface TaskRepository extends BaseRepository<Task, Long> {
	List<Task> findByProjectId(long projectId);

	List<Task> findByCategoryId(long categoryId);

	List<Task> findByUserId(long userId);

	void deleteByProjectId(long projectId);
}
