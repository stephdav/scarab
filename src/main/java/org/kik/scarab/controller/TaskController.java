package org.kik.scarab.controller;

import org.kik.scarab.model.Task;
import org.kik.scarab.service.TaskService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/tasks")
public class TaskController {

	private static final Logger LOGGER = LoggerFactory
			.getLogger(TaskController.class);

	@Autowired
	private TaskService svcTask;

	public TaskController() {
		// Empty constructor
	}

	public TaskController(final TaskService svc) {
		this.svcTask = svc;
	}

	/**
	 * Update the status of a task
	 * 
	 * @param projectId
	 * @param taskId
	 * @param taskStatus
	 * @return
	 */
	@RequestMapping(value = "/{taskId}", method = RequestMethod.PATCH)
	public @ResponseBody ResponseEntity<String> updateTaskStatus(
			@PathVariable String taskId,
			@RequestParam("status") String taskStatus) {
		LOGGER.info("[API] PATCH status '" + taskStatus + "' for task "
				+ taskId);
		HttpStatus status = HttpStatus.OK;
		svcTask.updateTaskStatus(Long.valueOf(taskId), Long.valueOf(taskStatus));
		return new ResponseEntity<String>(status);
	}

	/**
	 * Update a task
	 * 
	 * @param projectId
	 * @param taskId
	 * @param taskStatus
	 * @return
	 */
	@RequestMapping(value = "/{taskId}", method = RequestMethod.PUT)
	public @ResponseBody ResponseEntity<String> updateTask(
			@PathVariable String taskId, @RequestBody Task task) {
		LOGGER.info("[API] PUT task " + taskId);
		task.setId(Long.valueOf(taskId));
		HttpStatus status = HttpStatus.OK;
		svcTask.updateTask(task);
		return new ResponseEntity<String>(status);
	}

	/**
	 * Delete a task.
	 * 
	 * @param projectId
	 * @param taskId
	 * @return
	 */
	@RequestMapping(value = "/{taskId}", method = RequestMethod.DELETE)
	public ResponseEntity<Task> deleteTask(@PathVariable String taskId) {
		LOGGER.info("[API] DELETE task " + taskId);
		HttpStatus status = HttpStatus.NO_CONTENT;
		svcTask.deleteTask(Long.valueOf(taskId));
		return new ResponseEntity<Task>(status);
	}
}