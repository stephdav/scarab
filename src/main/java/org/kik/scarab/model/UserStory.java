package org.kik.scarab.model;

import java.util.Date;

import org.codehaus.jackson.map.annotate.JsonSerialize;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@JsonSerialize(include = JsonSerialize.Inclusion.NON_NULL)
@Document
public class UserStory {

	@Id
	private String id;
	private String code;
	private String title;
	private String description;
	private String accCrit;
	private String accTest;
	private Date creationDate;

	public UserStory() {
		// Empty constructor
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getAccCrit() {
		return accCrit;
	}

	public void setAccCrit(String accCrit) {
		this.accCrit = accCrit;
	}

	public String getAccTest() {
		return accTest;
	}

	public void setAccTest(String accTest) {
		this.accTest = accTest;
	}

	public Date getCreationDate() {
		return creationDate;
	}

	public void setCreationDate(Date creationDate) {
		this.creationDate = creationDate;
	}

}
