package org.kik.scarab.controller;

import java.util.Map;

import org.kik.scarab.model.Project;
import org.kik.scarab.model.Task;
import org.kik.scarab.service.ProjectService;
import org.kik.scarab.service.TaskService;
import org.kik.scarab.service.UserService;
import org.kik.scarab.utils.PageUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class PageController {

	private static final Logger LOGGER = LoggerFactory
			.getLogger(PageController.class);

	@Value("${application.message:Hello World}")
	private String message = "Hello World";

	@Autowired
	ProjectService svcProject;

	@Autowired
	TaskService svcTask;

	@Autowired
	UserService svcUser;

	@RequestMapping("/")
	public ModelAndView welcome() {
		LOGGER.debug("[GET] /");
		Authentication auth = SecurityContextHolder.getContext()
				.getAuthentication();
		ModelAndView model = PageUtils.initModelAndView("home", "welcome "
				+ auth.getName() + "!");
		return model;
	}

	@RequestMapping("/foo")
	public String foo(Map<String, Object> model) {
		throw new RuntimeException("Foo");
	}

	@RequestMapping(value = "/projectNew", method = RequestMethod.GET)
	public ModelAndView projectPage() {
		LOGGER.debug("[GET] /projectNew");
		ModelAndView model = PageUtils.initModelAndView("projectNew",
				"new project");
		return model;
	}

	@RequestMapping(value = "/projects/{id}", method = RequestMethod.GET)
	public ModelAndView editProjectPage(@PathVariable String id) {
		LOGGER.debug("[GET] /projects/{}", id);
		Project project = svcProject.getProject(Long.valueOf(id));
		ModelAndView model = PageUtils.initModelAndView("editProject",
				"edit project");
		PageUtils.addProjectInfo(model, project);
		return model;
	}

	@RequestMapping(value = "/projects/{id}/board", method = RequestMethod.GET)
	public ModelAndView projectsPage(@PathVariable String id) {
		LOGGER.debug("[GET] /projects/{}/board", id);
		Project project = svcProject.getProject(Long.valueOf(id));
		ModelAndView model = PageUtils.initModelAndView("tasks", "project "
				+ project.getName());
		PageUtils.addProjectInfo(model, project);
		PageUtils.addUsersList(model, svcUser.getList());
		return model;
	}

	@RequestMapping(value = "/projects/{id}/dashboard", method = RequestMethod.GET)
	public ModelAndView projectDashboardPage(@PathVariable String id) {
		LOGGER.debug("[GET] /projects/{}/dashboard", id);
		Project project = svcProject.getProject(Long.valueOf(id));
		ModelAndView model = PageUtils.initModelAndView("projectdashboard",
				"project " + project.getName() + " - dashboard");
		PageUtils.addProjectInfo(model, project);
		return model;
	}

	@RequestMapping(value = "/projects/{projectId}/tasks/{taskId}", method = RequestMethod.GET)
	public ModelAndView editTaskPage(@PathVariable String projectId,
			@PathVariable String taskId) {
		LOGGER.debug("[GET] /projects/{}/tasks/{}", projectId, taskId);
		Project project = svcProject.getProject(Long.valueOf(projectId));
		Task task = svcTask.getTask(Long.valueOf(taskId));
		ModelAndView model = PageUtils
				.initModelAndView("editTask", "edit task");
		PageUtils.addProjectInfo(model, project);
		PageUtils.addTaskInfo(model, task);
		PageUtils.addUsersList(model, svcUser.getList());
		return model;
	}

	@RequestMapping(value = "/admin**", method = RequestMethod.GET)
	public ModelAndView adminPage() {
		LOGGER.debug("[GET] /admin");
		ModelAndView model = PageUtils.initModelAndView("admin",
				"administration");
		return model;
	}
}
