$(document).ready(function() {
	$('div.form-group-options').on('focus', 'div.input-group-option:last-child input', function(){
		var sInputGroupHtml = $(this).parent().html();
		var sInputGroupClasses = $(this).parent().attr('class');
		$(this).parent().parent().append('<div class="'+sInputGroupClasses+'">'+sInputGroupHtml+'</div>');
	});
	
	$('div.form-group-options').on('click', '.input-group-addon-remove', function(){
		$(this).parent().remove();
	});
	
	$('#inputValue').val("");
	
	var idx=0;
	var defaultColumns = [ "BACKLOG", "TODO", "PENDING", "DONE" ];
	$("[name=column\\[\\]]").each(function(index, element) {
		$(element).val(defaultColumns[index]);
	});

	var idx=0;
	var defaultCategory = [ "ANOMALIE", "EVOLUTION" ];
	$("[name=category\\[\\]]").each(function(index, element) {
		$(element).val(defaultCategory[index]);
	});

	$('#inputValue').focus();

	$('.submitForm').on('click', function(e) {

		var columns = [];
		$("[name=column\\[\\]]").each(function(index, element) {
			columns.push($(element).val());
		});

		var categories = [];
		$("[name=category\\[\\]]").each(function(index, element) {
			categories.push($(element).val());
		});

		createProject($('#inputValue').val(), columns, categories);
	});

	$('.cancelForm').on('click', function(e) {
		goTo("");
	});

});

function createProject(name, columns, categories) {
	apiProjectsCreate(
		name, columns, categories,
		function(data) {
			showAlertSuccess("Project " + name + " created.");
			goTo("");
		},
		function(textStatus, errorThrown) {
			showAlertError('Failed to create project ' + name + '.');
			goTo("");
		});
}

// End of File