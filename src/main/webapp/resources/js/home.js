$(document).ready(function() {
	$('#refreshProjects').on('click', function(e) {
		updateProjectsList();
	});
	$('#projects').on('click','li', function(e) {
		e.stopPropagation();
		var projectId = $(this).attr('data-prj');
		goTo("projects/" + projectId + "/board");
	});
	$('#projects').on('click','.deleteProject', function(e) {
		e.stopPropagation();
		var projectId = $(this).closest('li').attr('data-prj');
		deleteProject(projectId);
	});
	updateProjectsList();
});

function updateProjectsList() {
	$.ajax({
		url : "api/projects"
	}).then(function(data) {
		$('#projects').empty();
		$.each(data, function(index, value) {
			$('#projects').append('<li class="list-group-item" data-prj="' + value.id + '">#' + value.id + '&nbsp;' + value.name + '<button type="button" class="deleteProject btn btn-sm btn-default pull-right"><span class="fa fa-close" aria-hidden="true"></span></button></li>');
		});
	});
}

function deleteProject(id) {
	apiProjectsDelete(
		id,
		function(data) {
			showAlertSuccess('Project deleted.');
			updateProjectsList();
		},
		function(textStatus, errorThrown) {
			showAlertError('Failed to delete project.');
			updateProjectsList();
		});
}

// End of File