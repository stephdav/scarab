package org.kik.scarab.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Entity
@Table(name = "CYCLE_TIME")
public class CycleTime {

	@Id
	@Column(name = "ID", nullable = false, updatable = false)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ct_seq")
	@SequenceGenerator(name = "ct_seq", sequenceName = "CYCLE_TIME_ID_SEQ", allocationSize = 1)
	private long id;

	@ManyToOne
	@JoinColumn(name = "TASK_ID")
	private Task task;

	@ManyToOne
	@JoinColumn(name = "STATUS_ID")
	private Status status;

	@Column(name = "SPENT_TIME", nullable = false)
	private long spentTime;

	public CycleTime() {
		// empty constructor
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Task getTask() {
		return task;
	}

	public void setTask(Task task) {
		this.task = task;
	}

	public Status getStatus() {
		return status;
	}

	public void setStatus(Status status) {
		this.status = status;
	}

	public long getSpentTime() {
		return spentTime;
	}

	public void setSpentTime(long spentTime) {
		this.spentTime = spentTime;
	}

}
