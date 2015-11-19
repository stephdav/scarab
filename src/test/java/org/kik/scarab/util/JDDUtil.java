package org.kik.scarab.util;

import java.util.ArrayList;
import java.util.List;

import org.kik.scarab.model.Project;
import org.kik.scarab.model.User;

public class JDDUtil {

	private static final long PRJ_ID = 1L;
	private static final String PRJ_NAME = "kanban";
	private static final String PRJ_DESC = "an agile project";

	private static final long USR_ID = 1L;
	private static final String USR_USERNAME = "username";
	private static final String USR_PASSWORD = "password";
	private static final String USR_ROLE = "USER";

	private JDDUtil() {
	}

	public static User createUser() {
		return new User(USR_ID, USR_USERNAME, USR_PASSWORD, USR_ROLE);
	}

	public static List<User> createUserList(int howMany) {
		List<User> userList = new ArrayList<>();
		for (int i = 0; i < howMany; i++) {
			userList.add(new User(i, USR_USERNAME + "#" + i, USR_PASSWORD,
					USR_ROLE));
		}
		return userList;
	}

	public static Project createProject() {
		return new Project(PRJ_ID, PRJ_NAME, PRJ_DESC);
	}

	public static List<Project> createProjectList(int howMany) {
		List<Project> projectList = new ArrayList<>();
		for (int i = 0; i < howMany; i++) {
			projectList.add(new Project(i, PRJ_NAME + "#" + i, PRJ_DESC));
		}
		return projectList;
	}
}
