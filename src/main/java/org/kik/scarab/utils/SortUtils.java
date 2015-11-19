package org.kik.scarab.utils;

import java.util.Comparator;

import org.kik.scarab.model.User;

public class SortUtils {

	private SortUtils() {
		// static class
	}

	public static Comparator<User> sortUsersByUsername = new Comparator<User>() {

		@Override
		public int compare(User o1, User o2) {
			int res = 0;
			if (o1 == null && o2 != null) {
				res = -1;
			} else if (o1 != null && o2 == null) {
				res = 1;
			} else if (o1 != null && o2 != null) {
				res = o1.getUsername().compareTo(o2.getUsername());
			}
			return res;
		}
	};
}
