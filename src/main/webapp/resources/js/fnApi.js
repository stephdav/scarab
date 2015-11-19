function apiProjectsCreate(projectName, columns, categories, successCallback, errorCallback) {

	var data = '{ "name": "' + projectName + '"';
	data += getElementsAsArray(columns, "columns");
	data += getElementsAsArray(categories, "categories");
	data +=' }';

	$.ajax({
		url : contextPath + "/api/projects",
		type : 'POST',
		dataType : 'text',
		contentType : "application/json; charset=utf-8",
		data : data,
		success : successCallback,
		error : errorCallback
	});
}

function apiProjectsUpdate(id, projectName, projectId, columns, categories, successCallback, errorCallback) {

	var data = '{';
	data += ' "projectId": "' + projectId + '"';
	data += ', "name": "' + projectName + '"';
	data += getElementsAsArray(columns, "columns");
	data += getElementsAsArray(categories, "categories");
	data +=' }';

	$.ajax({
		url : contextPath + "/api/projects/" + id,
		type : 'PUT',
		dataType : 'text',
		contentType : "application/json; charset=utf-8",
		data : data,
		success : successCallback,
		error : errorCallback
	});
}

function getElementsAsArray(elements, arrayName) {
	var data = "";
	if (elements.length > 0) {
		data += ', "' + arrayName + '": [';
		$.each(elements, function(index, elt) {
			if (elt != "") {
				if (index > 0) {
					data += ', ';
				}
				data += '{ "name": "' + elt + '" }';
			}
		});
		data += ' ]';
	}
	return data;
}

function apiProjectsDelete(projectId, successCallback, errorCallback) {
	$.ajax({
		url : contextPath + "/api/projects/" + projectId,
		type : 'DELETE',
		dataType : 'text',
		contentType : "application/json; charset=utf-8",
		success : successCallback,
		error : errorCallback
	});
}

function apiTasksCreate(projectId, taskTitle, taskDescription, taskStatus, taskCategory, assigned, successCallback, errorCallback) {
	var data = '{ "title": "' + taskTitle + '"';
	if (taskDescription != "") {
		data += ', "description": "' + taskDescription + '"';
	}
	if (taskStatus != "") {
		data += ', "status": {"id": "' + taskStatus + '"}';
	}
	if (taskCategory != "") {
		data += ', "category": {"id": "' + taskCategory + '"}';
	}
	if (assigned != "") {
		data += ', "user": {"id": "' + assigned + '"}';
	}
	data += ' }';
	$.ajax({
		url : contextPath + "/api/projects/" + projectId + "/tasks",
		type : 'POST',
		dataType : 'text',
		contentType : "application/json; charset=utf-8",
		data : data,
		success : successCallback,
		error : errorCallback
	});
}

function apiTasksUpdate(id, taskTitle, taskDescription, taskStatus, taskCategory, projectId, assigned, successCallback, errorCallback) {
	var data = '{ "id": ' + id + ', "title": "' + taskTitle + '"';
	if (taskDescription != "") {
		data += ', "description": "' + taskDescription + '"';
	}
	if (projectId != "") {
		data += ', "project": {"id": "' + projectId + '"}';
	}
	if (taskStatus != "") {
		data += ', "status": {"id": "' + taskStatus + '"}';
	}
	if (taskCategory != "") {
		data += ', "category": {"id": "' + taskCategory + '"}';
	}
	if (assigned != "") {
		data += ', "user": {"id": "' + assigned + '"}';
	}
	data += ' }';
	$.ajax({
		url : contextPath + "/api/tasks/" + id,
		type : 'PUT',
		dataType : 'text',
		contentType : "application/json; charset=utf-8",
		data : data,
		success : successCallback,
		error : errorCallback
	});
}

function apiTasksUpdateStatus(taskId, taskStatus, successCallback, errorCallback) {
	$.ajax({
		url : contextPath + "/api/tasks/" + taskId + "?status="+taskStatus,
		type : 'PATCH',
		dataType : 'text',
		contentType : "application/json; charset=utf-8",
		success : successCallback,
		error : errorCallback
	});
}

function apiTaskDelete(taskId, successCallback, errorCallback) {
	$.ajax({
		url : contextPath + "/api/tasks/" + taskId,
		type : 'DELETE',
		dataType : 'text',
		contentType : "application/json; charset=utf-8",
		success : successCallback,
		error : errorCallback
	});
}

function apiProjectDashboardDoughnut(projectId, fieldname, successCallback, errorCallback) {
	$.ajax({
		url : contextPath + "/api/projects/" + projectId + "/dashboard/doughnut?field=" + fieldname,
		success : successCallback,
		error : errorCallback
	});
}

function apiProjectDashboardCycleTime(projectId, successCallback, errorCallback) {
	$.ajax({
		url : contextPath + "/api/projects/" + projectId + "/dashboard/cycleTime",
		success : successCallback,
		error : errorCallback
	});
}

function apiUserCreate(username, password, isAdmin, successCallback, errorCallback) {
	var data = '{'
		+ ' "username": "' + username + '",'
		+ ' "password": "' + password + '"';
	if (isAdmin) {
		data+= ', "role": "ROLE_ADMIN"';
	} else {
		data+= ', "role": "ROLE_USER"';
	}
	data+= ' }';
	$.ajax({
		url : contextPath + "/api/users/",
		type : 'POST',
		dataType : 'text',
		contentType : "application/json; charset=utf-8",
		data : data,
		success : successCallback,
		error : errorCallback
	});
}

function apiUserDelete(userId, successCallback, errorCallback) {
	$.ajax({
		url : contextPath + "/api/users/" + userId,
		type : 'DELETE',
		dataType : 'text',
		contentType : "application/json; charset=utf-8",
		success : successCallback,
		error : errorCallback
	});
}