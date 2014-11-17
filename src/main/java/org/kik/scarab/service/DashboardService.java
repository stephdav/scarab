package org.kik.scarab.service;

import org.kik.scarab.dao.UserStoryDao;
import org.kik.scarab.model.DashboardSummary;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DashboardService {

	@Autowired
	private UserStoryDao dao;

	public DashboardService() {
		// Empty constructor
	}

	/**
	 * Constructor for Unit Testing
	 * 
	 * @param dao
	 */
	public DashboardService(final UserStoryDao dao) {
		this.dao = dao;
	}

	public DashboardSummary getSummary() {
		DashboardSummary summary = new DashboardSummary();
		summary.setUsCount(dao.getUserStoryCount());
		return summary;
	}

}
