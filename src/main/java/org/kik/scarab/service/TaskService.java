package org.kik.scarab.service;

import java.util.List;

import org.kik.scarab.model.Task;

public interface TaskService {

	Task getTask(long id);

	List<Task> getUserList(long userId);

	void deleteTask(long taskId);

	void updateTask(Task task);

	void updateTaskStatus(long id, long status);
}
