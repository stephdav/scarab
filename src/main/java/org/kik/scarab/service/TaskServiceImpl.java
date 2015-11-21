package org.kik.scarab.service;

import java.util.List;
import java.util.Optional;

import org.kik.scarab.dao.CategoryRepository;
import org.kik.scarab.dao.CycleTimeRepository;
import org.kik.scarab.dao.ProjectRepository;
import org.kik.scarab.dao.StatusRepository;
import org.kik.scarab.dao.TaskRepository;
import org.kik.scarab.dao.UserRepository;
import org.kik.scarab.model.Category;
import org.kik.scarab.model.CycleTime;
import org.kik.scarab.model.Project;
import org.kik.scarab.model.Status;
import org.kik.scarab.model.Task;
import org.kik.scarab.model.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TaskServiceImpl implements TaskService {

	private static final Logger LOGGER = LoggerFactory
			.getLogger(TaskServiceImpl.class);

	@Autowired
	private ProjectRepository daoProject;

	@Autowired
	private TaskRepository daoTask;

	@Autowired
	private StatusRepository daoStatus;

	@Autowired
	private CategoryRepository daoCategory;

	@Autowired
	private UserRepository daoUser;

	@Autowired
	private CycleTimeRepository daoCycleTime;

	public TaskServiceImpl() {
		// Empty constructor
	}

	public TaskServiceImpl(final TaskRepository repository) {
		this.daoTask = repository;
	}

	@Override
	public Task getTask(long id) {
		Task t = daoTask.findOne(id).get();
		return t;
	}

	@Override
	public List<Task> getUserList(long userId) {
		return daoTask.findByUserId(userId);
	}

	@Override
	public void updateTaskStatus(long id, long status) {
		Optional<Task> opt = daoTask.findOne(id);
		if (opt.isPresent()) {
			Task task = opt.get();
			updateCycleTime(task);

			Optional<Status> opt2 = daoStatus.findOne(status);
			if (opt2.isPresent()) {
				task.setStatus(opt2.get());
				daoTask.save(task);
			}
		}
	}

	@Override
	public void updateTask(Task task) {

		Task t = daoTask.findOne(task.getId()).get();

		t.setTitle(task.getTitle());
		t.setDescription(task.getDescription());

		if (task.getProject() != null) {
			Optional<Project> p = daoProject.findOne(task.getProject().getId());
			if (p.isPresent()) {
				task.setProject(p.get());
			}
		}

		if (task.getStatus() != null) {
			Optional<Status> s = daoStatus.findOne(Long.valueOf(task
					.getStatus().getId()));
			if (s.isPresent()) {
				task.setStatus(s.get());
			}
		} else {
			t.setStatus(null);
		}
		if (task.getCategory() != null) {
			Optional<Category> s = daoCategory.findOne(Long.valueOf(task
					.getCategory().getId()));
			if (s.isPresent()) {
				task.setCategory(s.get());
			}
		} else {
			t.setCategory(null);
		}
		if (task.getUser() != null) {
			Optional<User> u = daoUser.findOne(Long.valueOf(task.getUser()
					.getId()));
			if (u.isPresent()) {
				task.setUser(u.get());
			}
		} else {
			t.setUser(null);
		}

		daoTask.save(task);
	}

	@Override
	public void deleteTask(long taskId) {
		Optional<Task> opt = daoTask.findOne(taskId);
		if (opt.isPresent()) {
			daoCycleTime.deleteByTaskId(taskId);
			daoTask.delete(opt.get());
		}
	}

	private void updateCycleTime(final Task task) {

		Status oldStatus = task.getStatus();

		long now = System.currentTimeMillis();
		long delta = (now - task.getLastUpdate()) / 1000L;

		CycleTime sctToUpdate = daoCycleTime.findFirstByTaskIdAndStatusId(
				task.getId(), oldStatus.getId());

		if (sctToUpdate == null) {
			LOGGER.debug("new CycleTime for task " + task.getId()
					+ " and status " + oldStatus.getId());
			sctToUpdate = new CycleTime();
			sctToUpdate.setTask(task);
			sctToUpdate.setStatus(oldStatus);
		}
		sctToUpdate.setSpentTime(sctToUpdate.getSpentTime() + delta);
		daoCycleTime.save(sctToUpdate);

		LOGGER.info("add " + delta + " seconds for status "
				+ oldStatus.getName());

		task.setLastUpdate(now);
	}

}
