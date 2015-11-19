package org.kik.scarab.dao;

import org.kik.scarab.model.User;

public interface UserRepository extends BaseRepository<User, Long> {
	User findFirstByUsername(String username);
}
