package org.kik.scarab.controller;

import java.util.List;

import org.kik.scarab.model.Project;
import org.kik.scarab.model.Task;
import org.kik.scarab.model.dashboard.Doughnut;
import org.kik.scarab.service.ProjectService;
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
@RequestMapping("/api/projects")
public class ProjectController {

	private static final Logger LOGGER = LoggerFactory
			.getLogger(ProjectController.class);

	@Autowired
	private ProjectService projectSvc;

	public ProjectController() {
		// Empty constructor
	}

	public ProjectController(final ProjectService userService) {
		this.projectSvc = userService;
	}

	/**
	 * GET the list of all projects.
	 * 
	 * @return a list of {@link Project}
	 */
	@RequestMapping(value = "", method = RequestMethod.GET)
	public ResponseEntity<List<Project>> getProjects() {
		LOGGER.info("[API] GET projects");
		return new ResponseEntity<List<Project>>(projectSvc.getList(),
				HttpStatus.OK);
	}

	@RequestMapping(value = "", method = RequestMethod.POST)
	public @ResponseBody ResponseEntity<String> createProject(
			@RequestBody Project project) {
		LOGGER.info("[API] POST a new project");
		HttpStatus status = HttpStatus.CREATED;
		try {
			projectSvc.save(project);
		} catch (Exception e) {
			status = HttpStatus.INTERNAL_SERVER_ERROR;
			LOGGER.error("can not create project");
		}
		return new ResponseEntity<String>(status);
	}

	/**
	 * Update a project.
	 * 
	 * @param projectId
	 *            Id of the project
	 * @return
	 */
	@RequestMapping(value = "/{projectId}", method = RequestMethod.PUT)
	public ResponseEntity<Task> updateProject(@PathVariable String projectId,
			@RequestBody Project project) {
		LOGGER.info("[API] PUT project " + projectId);
		HttpStatus status = HttpStatus.NO_CONTENT;
		projectSvc.updateProject(project);
		return new ResponseEntity<Task>(status);
	}

	/**
	 * Delete a project.
	 * 
	 * @param projectId
	 *            Id of the project
	 * @return
	 */
	@RequestMapping(value = "/{projectId}", method = RequestMethod.DELETE)
	public ResponseEntity<String> deleteProject(@PathVariable String projectId) {
		LOGGER.info("[API] DELETE project " + projectId);
		HttpStatus status = HttpStatus.NO_CONTENT;
		projectSvc.deleteProject(Long.valueOf(projectId));
		return new ResponseEntity<String>(status);
	}

	/**
	 * Get all tasks of a project.
	 * 
	 * @param projectId
	 *            Id of the project
	 * @return
	 */
	@RequestMapping(value = "/{projectId}/tasks", method = RequestMethod.GET)
	public ResponseEntity<List<Task>> getAllTasks(@PathVariable String projectId) {
		LOGGER.info("[API] GET all tasks of project " + projectId);
		HttpStatus status = HttpStatus.OK;
		return new ResponseEntity<List<Task>>(projectSvc.getTaskslist(Long
				.valueOf(projectId)), status);
	}

	/**
	 * Create a task in a project.
	 * 
	 * @param projectId
	 *            Id of the project
	 * @param task
	 *            The {@link Task} to create
	 * @return
	 */
	@RequestMapping(value = "/{projectId}/tasks", method = RequestMethod.POST)
	public @ResponseBody ResponseEntity<String> createTask(
			@PathVariable String projectId, @RequestBody Task task) {
		LOGGER.info("[API] POST a new task");
		HttpStatus status = HttpStatus.CREATED;
		projectSvc.saveTask(Long.valueOf(projectId), task);
		return new ResponseEntity<String>(status);
	}

	/**
	 * Get project dashboard data.
	 * 
	 * @param projectId
	 *            Id of the project
	 * @return
	 */
	@RequestMapping(value = "/{projectId}/dashboard/cycleTime", method = RequestMethod.GET)
	public ResponseEntity<List<Doughnut>> getProjectCycleTime(
			@PathVariable String projectId) {

		LOGGER.info("[API] GET dashboard cycle time data of project "
				+ projectId);

		HttpStatus status = HttpStatus.OK;
		return new ResponseEntity<List<Doughnut>>(projectSvc.getCycleTime(Long
				.valueOf(projectId)), status);
	}

	/**
	 * Get project dashboard data.
	 * 
	 * @param projectId
	 *            Id of the project
	 * @return
	 */
	@RequestMapping(value = "/{projectId}/dashboard/doughnut", params = "field", method = RequestMethod.GET)
	public ResponseEntity<List<Doughnut>> getProjectDoughnut(
			@PathVariable String projectId, @RequestParam String field) {
		LOGGER.info("[API] GET dashboard doughnut data of project " + projectId);

		HttpStatus status = HttpStatus.OK;
		return new ResponseEntity<List<Doughnut>>(projectSvc.getDashboardData(
				Long.valueOf(projectId), field), status);
	}
}