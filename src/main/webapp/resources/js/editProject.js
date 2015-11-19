$(document).ready(function() {

	$('div.form-group-options').on('focus', 'div.input-group-option:last-child input', function(){
		var sInputGroupHtml = $(this).parent().html();
		var sInputGroupClasses = $(this).parent().attr('class');
		$(this).parent().parent().append('<div class="'+sInputGroupClasses+'">'+sInputGroupHtml+'</div>');
	});
	
	$('div.form-group-options').on('click', '.input-group-addon-remove', function(){
		$(this).parent().remove();
	});

	$('#projectName').focus();

	$('.submitForm').on('click', function(e) {

		var columns = [];
		$("[name=column\\[\\]]").each(function(index, element) {
			columns.push($(element).val());
		});

		var categories = [];
		$("[name=category\\[\\]]").each(function(index, element) {
			categories.push($(element).val());
		});

		updateProject(
			$('#projectId').val(),
			$('#projectName').val(),
			$('#projectProjectId').val(),
			columns,
			categories);
	});

	$('.cancelForm').on('click', function(e) {
		goTo("projects/" + $("#projectId").val() + "/board");
	});

});

function updateProject(id, name, projectId, columns, categories) {
	apiProjectsUpdate(
		id, name, projectId, columns, categories,
		function(data) {
			showAlertSuccess("Project " + name + " created.");
			goTo("projects/" + id + "/board");
		},
		function(textStatus, errorThrown) {
			showAlertError('Failed to create project ' + name + '.');
			goTo("projects/" + id + "/board");
		});
}

// End of File