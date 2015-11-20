package org.kik.scarab.service;

import java.util.List;

import org.kik.scarab.model.Project;
import org.kik.scarab.model.Task;
import org.kik.scarab.model.dashboard.Bar;
import org.kik.scarab.model.dashboard.Doughnut;
import org.kik.scarab.service.exception.FunctionalException;

public interface ProjectService {

	Project getProject(long id);

	Project save(Project user) throws FunctionalException;

	void updateProject(Project project) throws FunctionalException;

	List<Project> getList();

	void deleteProject(long id);

	// === tasks =====================================================

	Task saveTask(long projectId, Task task);

	List<Task> getTaskslist(long projectId);

	// === Dashboard methods =================================================

	List<Doughnut> getDashboardData(long projectId, String field);

	List<Doughnut> getCycleTime(long projectId);

	Bar getCycleTimeAsBar(long projectId);
}