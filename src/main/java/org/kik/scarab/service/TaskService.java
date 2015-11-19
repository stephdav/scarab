package org.kik.scarab.service;

import org.kik.scarab.model.Task;

public interface TaskService {
	Task getTask(long id);

	void deleteTask(long taskId);

	void updateTask(Task task);

	void updateTaskStatus(long id, long status);
}
