package org.kik.scarab.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.kik.scarab.model.CycleTime;
import org.kik.scarab.model.Task;
import org.kik.scarab.model.dashboard.ChartData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CustomRepositoryImpl implements CustomRepository {

	@Autowired
	TaskRepository daoTask;

	@Autowired
	CycleTimeRepository daoCycleTime;

	@Override
	public List<ChartData> getTasksPerCategory(long projectId) {

		Map<String, ChartData> datas = new HashMap<String, ChartData>();
		ChartData cd = new ChartData();
		cd.setLabel("Sans catégorie");
		datas.put("Sans catégorie", cd);

		List<Task> tasks = daoTask.findByProjectId(projectId);

		for (Task task : tasks) {
			ChartData dd = null;
			if (task.getCategory() != null) {
				dd = datas.get(task.getCategory().getName());
				if (dd == null) {
					dd = new ChartData();
					dd.setLabel(task.getCategory().getName());
					datas.put(task.getCategory().getName(), dd);
				}
			} else {
				dd = datas.get("Sans catégorie");
			}
			dd.setTotal(dd.getTotal() + 1);
		}

		return new ArrayList<ChartData>(datas.values());
	}

	@Override
	public List<ChartData> getTasksPerStatus(long projectId) {

		Map<String, ChartData> datas = new HashMap<String, ChartData>();

		List<Task> tasks = daoTask.findByProjectId(projectId);

		for (Task task : tasks) {

			ChartData dd = datas.get(task.getStatus().getName());
			if (dd == null) {
				dd = new ChartData();
				dd.setLabel(task.getStatus().getName());
				datas.put(task.getStatus().getName(), dd);
			}
			dd.setTotal(dd.getTotal() + 1);
		}

		return new ArrayList<ChartData>(datas.values());
	}

	@Override
	public List<ChartData> getTasksPerUser(long projectId) {

		Map<String, ChartData> datas = new HashMap<String, ChartData>();

		ChartData dd0 = new ChartData();
		dd0.setLabel("Non assigné");
		datas.put("Non assigné", dd0);

		List<Task> tasks = daoTask.findByProjectId(projectId);

		for (Task task : tasks) {
			ChartData dd = null;
			if (task.getUser() != null) {
				dd = datas.get(task.getUser().getUsername());
				if (dd == null) {
					dd = new ChartData();
					dd.setLabel(task.getUser().getUsername());
					datas.put(task.getUser().getUsername(), dd);
				}
			} else {
				dd = datas.get("Non assigné");
			}
			dd.setTotal(dd.getTotal() + 1);
		}

		return new ArrayList<ChartData>(datas.values());
	}

	/**
	 * @param projectId
	 * @return temps (en heure) de cycle moyen par status
	 */
	@Override
	public List<ChartData> getCycleTimeData(long projectId) {

		Map<String, ChartData> datas = new HashMap<String, ChartData>();

		List<Task> tasks = daoTask.findByProjectId(projectId);

		// analyse temps finis
		for (CycleTime sct : daoCycleTime.findByTaskProjectId(projectId)) {
			ChartData dd = datas.get(sct.getStatus().getName());
			if (dd == null) {
				dd = new ChartData();
				dd.setLabel(sct.getStatus().getName());
				datas.put(sct.getStatus().getName(), dd);
			}
			dd.setTotal(dd.getTotal() + (sct.getSpentTime() / 3600));
		}

		long now = System.currentTimeMillis();

		// Ajout temps en cours
		for (Task t : tasks) {
			ChartData dd = datas.get(t.getStatus().getName());
			if (dd == null) {
				dd = new ChartData();
				dd.setLabel(t.getStatus().getName());
				datas.put(t.getStatus().getName(), dd);
			}
			dd.setTotal(dd.getTotal() + ((now - t.getLastUpdate()) / 3600000));
		}

		long nbTasks = tasks.size();
		for (ChartData dd : datas.values()) {
			dd.setTotal(dd.getTotal() / nbTasks);
		}

		// remove empty values
		// List<String> toBeRemoved = new ArrayList<String>();
		// for (Map.Entry<String, ChartData> entry : datas.entrySet()) {
		// if (entry.getValue().getTotal() == 0) {
		// toBeRemoved.add(entry.getKey());
		// }
		// }
		// for (String key : toBeRemoved) {
		// datas.remove(key);
		// }

		return new ArrayList<ChartData>(datas.values());
	}
}
