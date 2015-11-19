package org.kik.scarab.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.kik.scarab.model.CycleTime;
import org.kik.scarab.model.Task;
import org.kik.scarab.model.dashboard.DoughnutData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CustomRepositoryImpl implements CustomRepository {

	@Autowired
	TaskRepository daoTask;

	@Autowired
	CycleTimeRepository daoCycleTime;

	@Override
	public List<DoughnutData> getTasksPerCategory(long projectId) {

		Map<String, DoughnutData> datas = new HashMap<String, DoughnutData>();

		List<Task> tasks = daoTask.findByProjectId(projectId);

		for (Task task : tasks) {
			DoughnutData dd = null;
			if (task.getCategory() != null) {
				dd = datas.get(task.getCategory().getName());
				if (dd == null) {
					dd = new DoughnutData();
					dd.setLabel(task.getCategory().getName());
					datas.put(task.getCategory().getName(), dd);
				}
			} else {
				dd = datas.get("Sans catégorie");
			}
			dd.setTotal(dd.getTotal() + 1);
		}

		return new ArrayList<DoughnutData>(datas.values());
	}

	@Override
	public List<DoughnutData> getTasksPerStatus(long projectId) {

		Map<String, DoughnutData> datas = new HashMap<String, DoughnutData>();

		List<Task> tasks = daoTask.findByProjectId(projectId);

		for (Task task : tasks) {

			DoughnutData dd = datas.get(task.getStatus().getName());
			if (dd == null) {
				dd = new DoughnutData();
				dd.setLabel(task.getStatus().getName());
				datas.put(task.getStatus().getName(), dd);
			}
			dd.setTotal(dd.getTotal() + 1);
		}

		return new ArrayList<DoughnutData>(datas.values());
	}

	@Override
	public List<DoughnutData> getTasksPerUser(long projectId) {

		Map<String, DoughnutData> datas = new HashMap<String, DoughnutData>();

		DoughnutData dd0 = new DoughnutData();
		dd0.setLabel("Non assigné");
		datas.put("Non assigné", dd0);

		List<Task> tasks = daoTask.findByProjectId(projectId);

		for (Task task : tasks) {
			DoughnutData dd = null;
			if (task.getUser() != null) {
				dd = datas.get(task.getUser().getUsername());
				if (dd == null) {
					dd = new DoughnutData();
					dd.setLabel(task.getUser().getUsername());
					datas.put(task.getUser().getUsername(), dd);
				}
			} else {
				dd = datas.get("Non assigné");
			}
			dd.setTotal(dd.getTotal() + 1);
		}

		return new ArrayList<DoughnutData>(datas.values());
	}

	/**
	 * @param projectId
	 * @return temps (en minutes) de cycle moyen par status
	 */
	@Override
	public List<DoughnutData> getCycleTimeData(long projectId) {

		Map<String, DoughnutData> datas = new HashMap<String, DoughnutData>();

		List<Task> tasks = daoTask.findByProjectId(projectId);

		for (CycleTime sct : daoCycleTime.findByTaskProjectId(projectId)) {
			DoughnutData dd = datas.get(sct.getStatus().getName());
			if (dd == null) {
				dd = new DoughnutData();
				dd.setLabel(sct.getStatus().getName());
				datas.put(sct.getStatus().getName(), dd);
			}
			dd.setTotal(dd.getTotal() + (sct.getSpentTime() / 60));
		}

		long nbTasks = tasks.size();
		for (DoughnutData dd : datas.values()) {
			dd.setTotal(dd.getTotal() / nbTasks);
		}

		return new ArrayList<DoughnutData>(datas.values());
	}
}
