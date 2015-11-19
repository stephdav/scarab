package org.kik.scarab.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.kik.scarab.dao.CategoryRepository;
import org.kik.scarab.dao.CustomRepository;
import org.kik.scarab.dao.CycleTimeRepository;
import org.kik.scarab.dao.ProjectRepository;
import org.kik.scarab.dao.StatusRepository;
import org.kik.scarab.dao.TaskRepository;
import org.kik.scarab.model.Category;
import org.kik.scarab.model.Project;
import org.kik.scarab.model.Status;
import org.kik.scarab.model.Task;
import org.kik.scarab.model.dashboard.Doughnut;
import org.kik.scarab.model.dashboard.DoughnutData;
import org.kik.scarab.service.exception.FunctionalException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ProjectServiceImpl implements ProjectService {

	private static final Logger LOGGER = LoggerFactory
			.getLogger(ProjectServiceImpl.class);

	@Autowired
	private ProjectRepository daoProject;

	@Autowired
	private StatusRepository daoStatus;

	@Autowired
	private CategoryRepository daoCategory;

	@Autowired
	private TaskRepository daoTask;

	@Autowired
	private CycleTimeRepository daoCycleTime;

	@Autowired
	private CustomRepository daoCustom;

	public ProjectServiceImpl() {
		// Empty constructor
	}

	public ProjectServiceImpl(final ProjectRepository repository) {
		this.daoProject = repository;
	}

	@Override
	@Transactional(readOnly = true)
	public List<Project> getList() {
		LOGGER.debug("Retrieving the list of all projects");
		return daoProject.findAll();
	}

	@Override
	public Project getProject(long id) {
		Project p = daoProject.findOne(id).get();
		p.setColumns(daoStatus.findByProjectId(p.getId()));
		p.setCategories(daoCategory.findByProjectId(p.getId()));
		return p;
	}

	@Override
	@Transactional
	public Project save(final Project project) throws FunctionalException {

		// Check fields
		if (project.getName() == null || project.getName().isEmpty()) {
			throw new FunctionalException("Project's name is mandatory.");
		}
		if (project.getColumns() == null || project.getColumns().size() < 2) {
			throw new FunctionalException("There must be at least two columns.");
		}

		Project p = daoProject.save(project);

		for (Status s : p.getColumns()) {
			s.setProject(p);
			daoStatus.save(s);
		}

		if (p.getCategories() != null) {
			for (Category c : p.getCategories()) {
				c.setProject(p);
				daoCategory.save(c);
			}
		}

		return p;
	}

	@Override
	public void updateProject(Project project) throws FunctionalException {

		// Check fields
		if (project.getName() == null || project.getName().isEmpty()) {
			throw new FunctionalException("Project's name is mandatory.");
		}
		if (project.getColumns() == null || project.getColumns().size() < 2) {
			throw new FunctionalException("There must be at least two columns.");
		}

		Project p = daoProject.findOne(project.getId()).get();
		p.setName(project.getName());
		p.setDescription(project.getDescription());
		daoProject.save(p);
	}

	@Override
	public void deleteProject(long id) {
		Optional<Project> opt = daoProject.findOne(id);
		if (opt.isPresent()) {
			daoCycleTime.deleteByTaskProjectId(id);
			daoTask.deleteByProjectId(id);
			daoStatus.deleteByProjectId(id);
			daoCategory.deleteByProjectId(id);
			daoProject.delete(opt.get());
		}
	}

	@Override
	public Task saveTask(long projectId, Task task) {
		Project p = getProject(projectId);
		task.setProject(p);
		if (task.getStatus() != null) {
			Optional<Status> s = daoStatus.findOne(Long.valueOf(task
					.getStatus().getId()));
			if (s.isPresent()) {
				task.setStatus(s.get());
			}
		}
		if (task.getCategory() != null) {
			Optional<Category> s = daoCategory.findOne(Long.valueOf(task
					.getCategory().getId()));
			if (s.isPresent()) {
				task.setCategory(s.get());
			}
		}
		task.setLastUpdate(System.currentTimeMillis());

		return daoTask.save(task);
	}

	@Override
	public List<Task> getTaskslist(long projectId) {
		List<Task> tasks = daoTask.findByProjectId(projectId);
		for (Task task : tasks) {
			task.getStatus().setProject(null);
			if (task.getCategory() != null) {
				task.getCategory().setProject(null);
			}
		}
		return tasks;
	}

	@Override
	public List<Doughnut> getCycleTime(long projectId) {
		List<DoughnutData> data = daoCustom.getCycleTimeData(projectId);

		String[] colors = { "#FAAA0A", "#41738C", "#31AF69", "#6FD51D" };
		int idx = 0;

		List<Doughnut> doughnuts = new ArrayList<Doughnut>();
		for (DoughnutData tc : data) {
			doughnuts.add(new Doughnut(tc.getTotal(), colors[idx++], "#ccc", tc
					.getLabel()));
			if (idx > 3) {
				idx = 0;
			}
		}

		return doughnuts;
	}

	@Override
	public List<Doughnut> getDashboardData(long projectId, final String field) {

		List<DoughnutData> data = null;

		if ("category".equals(field)) {
			data = daoCustom.getTasksPerCategory(projectId);
		} else if ("status".equals(field)) {
			data = daoCustom.getTasksPerStatus(projectId);
		} else if ("user".equals(field)) {
			data = daoCustom.getTasksPerUser(projectId);
		}

		String[] colors = { "#FAAA0A", "#41738C", "#31AF69", "#6FD51D" };
		int idx = 0;

		List<Doughnut> doughnuts = new ArrayList<Doughnut>();
		for (DoughnutData tc : data) {
			doughnuts.add(new Doughnut(tc.getTotal(), colors[idx++], "#ccc", tc
					.getLabel()));
			if (idx > 3) {
				idx = 0;
			}
		}

		return doughnuts;
	}

}
