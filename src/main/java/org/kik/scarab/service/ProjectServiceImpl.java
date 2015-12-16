package org.kik.scarab.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
import org.kik.scarab.model.dashboard.Bar;
import org.kik.scarab.model.dashboard.ChartData;
import org.kik.scarab.model.dashboard.Dataset;
import org.kik.scarab.model.dashboard.Doughnut;
import org.kik.scarab.service.exception.FunctionalException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ProjectServiceImpl implements ProjectService {

    private static final Logger LOGGER = LoggerFactory.getLogger(ProjectServiceImpl.class);

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

        checkProject(project);

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

        checkProject(project);

        Project p = daoProject.findOne(project.getId()).get();
        p.setName(project.getName());
        p.setDescription(project.getDescription());

        updateColumns(project, p);
        updateCategories(project, p);
        daoProject.save(p);
    }

    private void checkProject(final Project project) throws FunctionalException {
        // Check fields
        if (project.getName() == null || project.getName().isEmpty()) {
            throw new FunctionalException("Project's name is mandatory.");
        }
        if (project.getColumns() == null || project.getColumns().size() < 3) {
            throw new FunctionalException("There must be at least three columns.");
        }
    }

    /**
     * Update dst project with data of src one.
     * 
     * @param src
     * @param dst
     * @throws FunctionalException
     */
    private void updateColumns(Project src, Project dst) throws FunctionalException {

        List<Status> delete = new ArrayList<Status>();
        List<Status> update = new ArrayList<Status>();
        List<Status> create = new ArrayList<Status>();

        Map<Long, Status> newStatus = new HashMap<Long, Status>();
        for (Status s : src.getColumns()) {
            if (s.getId() != 0) {
                newStatus.put(s.getId(), s);
            } else {
                create.add(s);
            }
        }

        for (Status status : daoStatus.findByProjectId(dst.getId())) {
            Status s = newStatus.get(status.getId());
            if (s == null) {
                delete.add(status);
            } else {
                update.add(s);
            }
        }

        for (Status c : create) {
            c.setProject(dst);
            daoStatus.save(c);
        }
        for (Status c : update) {
            c.setProject(dst);
            daoStatus.save(c);
        }
        for (Status c : delete) {
            daoStatus.delete(c);
        }
        dst.setColumns(update);
        dst.getColumns().addAll(create);
    }

    /**
     * Update dst project with data of src one.
     * 
     * @param src
     * @param dst
     * @throws FunctionalException
     */
    private void updateCategories(Project src, Project dst) throws FunctionalException {

        List<Category> delete = new ArrayList<Category>();
        List<Category> update = new ArrayList<Category>();
        List<Category> create = new ArrayList<Category>();

        List<Long> dstIds = new ArrayList<Long>();

        List<Category> dstCat = daoCategory.findByProjectId(dst.getId());
        if (dstCat != null) {
            for (Category c : dstCat) {
                dstIds.add(c.getId());
            }
        }

        List<Long> srcIds = new ArrayList<Long>();
        if (src.getCategories() != null) {
            for (Category c : src.getCategories()) {
                if (c.getId() == 0) {
                    create.add(c);
                } else {
                    srcIds.add(c.getId());
                    update.add(c);
                }
            }
        }

        if (dstCat != null) {
            for (Category c : dstCat) {
                if (!srcIds.contains(c.getId())) {
                    if (!daoTask.findByCategoryId(c.getId()).isEmpty()) {
                        throw new FunctionalException("Some tasks belong to category " + c.getName());
                    }
                    delete.add(c);
                }
            }
        }

        for (Category c : create) {
            c.setProject(dst);
            daoCategory.save(c);
        }
        for (Category c : update) {
            c.setProject(dst);
            daoCategory.save(c);
        }
        for (Category c : delete) {
            daoCategory.delete(c);
        }
        dst.setCategories(update);
        dst.getCategories().addAll(create);
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
            Optional<Status> s = daoStatus.findOne(Long.valueOf(task.getStatus().getId()));
            if (s.isPresent()) {
                task.setStatus(s.get());
            }
        }
        if (task.getCategory() != null) {
            Optional<Category> s = daoCategory.findOne(Long.valueOf(task.getCategory().getId()));
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
        List<ChartData> data = daoCustom.getCycleTimeData(projectId);

        String[] colors = { "#FAAA0A", "#41738C", "#31AF69", "#6FD51D" };
        int idx = 0;

        List<Doughnut> doughnuts = new ArrayList<Doughnut>();
        for (ChartData tc : data) {
            doughnuts.add(new Doughnut(tc.getTotal(), colors[idx++], "#ccc", tc.getLabel()));
            if (idx > 3) {
                idx = 0;
            }
        }

        return doughnuts;
    }

    @Override
    public Bar getCycleTimeAsBar(long projectId) {

        List<String> labels = new ArrayList<String>();
        List<Long> datas = new ArrayList<Long>();

        List<ChartData> data = daoCustom.getCycleTimeData(projectId);
        for (ChartData tc : data) {
            labels.add(tc.getLabel());
            datas.add(tc.getTotal());
        }
        List<Dataset> datasets = new ArrayList<Dataset>();
        datasets.add(new Dataset("My First dataset", "220,220,220", datas));

        return new Bar(labels, datasets);
    }

    @Override
    public List<Doughnut> getDashboardData(long projectId, final String field) {

        List<ChartData> data = null;

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
        for (ChartData tc : data) {
            doughnuts.add(new Doughnut(tc.getTotal(), colors[idx++], "#ccc", tc.getLabel()));
            if (idx > 3) {
                idx = 0;
            }
        }

        return doughnuts;
    }

}
