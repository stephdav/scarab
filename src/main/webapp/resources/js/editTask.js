$(document).ready(function() {

	$("#taskDescription").text(replaceAll($("#taskDesc").val(), '<br>', '\n'));
	
	$('#taskTitle').focus();

	$('.submitForm').on('click', function(e) {
		updateTask(
			$("#taskId").val(),	
			$("#taskTitle").val(),
			replaceAll($("#taskDescription").val(), '\n', '<br>'),
			$("#taskStatus").val(),
			$("#taskCategory").val(),
			$("#projectId").val(),	
			$("#taskAssigned").val()
		);
	});

	$('.cancelForm').on('click', function(e) {
		goTo("projects/" + $("#projectId").val() + "/board");
	});

});

function updateTask(id, taskTitle, taskDescription, taskStatus, taskCategory, projectId, assigned) {
	apiTasksUpdate(
		id, taskTitle, taskDescription, taskStatus, taskCategory, projectId, assigned,
		function(data) {
			showAlertSuccess("Task #" + id + " updated.");
			goTo("projects/" + projectId + "/board");
		},
		function(textStatus, errorThrown) {
			showAlertError('Failed to update task #' + id + '.');
		});
}

// End of File