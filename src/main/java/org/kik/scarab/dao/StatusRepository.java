package org.kik.scarab.dao;

import java.util.List;

import org.kik.scarab.model.Status;

public interface StatusRepository extends BaseRepository<Status, Long> {
	List<Status> findByProjectId(long projectId);

	void deleteByProjectId(long projectId);
}
