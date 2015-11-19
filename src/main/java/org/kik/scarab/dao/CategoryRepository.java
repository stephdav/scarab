package org.kik.scarab.dao;

import java.util.List;

import org.kik.scarab.model.Category;

public interface CategoryRepository extends BaseRepository<Category, Long> {
	List<Category> findByProjectId(long projectId);

	void deleteByProjectId(long projectId);
}
