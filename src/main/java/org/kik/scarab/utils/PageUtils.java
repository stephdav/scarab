package org.kik.scarab.utils;

import java.util.List;

import org.kik.scarab.model.Project;
import org.kik.scarab.model.Task;
import org.kik.scarab.model.User;
import org.springframework.web.servlet.ModelAndView;

public class PageUtils {

	private PageUtils() {
		// static class
	}

	public static ModelAndView initModelAndView(final String viewName,
			final String pageTitle) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName(viewName);
		mv.addObject("title", pageTitle);
		return mv;
	}

	public static void addProjectInfo(ModelAndView mv, Project project) {
		mv.addObject("projectId", project.getId());
		mv.addObject("projectColumns", project.getColumns());
		mv.addObject("projectCategories", project.getCategories());
		mv.addObject("project", project);
	}

	public static void addTaskInfo(ModelAndView mv, Task task) {
		mv.addObject("task", task);
	}

	public static void addUsersList(ModelAndView mv, List<User> users) {
		mv.addObject("users", users);
	}
}
