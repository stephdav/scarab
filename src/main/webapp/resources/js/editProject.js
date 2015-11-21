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
			var colName = $(element).val();
			if (colName != "") {
				var colId = $(element).attr('data-col');
				var col = { id: colId, name: colName}
				columns.push(col);
			}
		});

		var categories = [];
		$("[name=category\\[\\]]").each(function(index, element) {
			var catName = $(element).val();
			if (catName != "") {
				var catId = $(element).attr('data-cat');
				var cat = { id: catId, name: catName}
				categories.push(cat);
			}
		});

		updateProject(
			$('#projectId').val(),
			$('#projectName').val(),
			replaceAll($("#projectDescription").val(), '\n', '<br>'),
			columns,
			categories);
	});

	$('.cancelForm').on('click', function(e) {
		goTo("projects/" + $("#projectId").val() + "/board");
	});

});

function updateProject(id, name, description, columns, categories) {
	apiProjectsUpdate(
		id, name, description, columns, categories,
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