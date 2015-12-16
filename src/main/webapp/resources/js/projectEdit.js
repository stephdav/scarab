$(document).ready(function() {

	$("#projectDescription").text(replaceAll($("#projectDesc").val(), '<br>', '\n'));

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

		if ($('#editProjectForm').valid()) {
			var columns = [];
			$("#dnd .statusLabel").each(function(index, element) {
				var colName = $(element).text();
				if (colName != "") {
					var colId = $(element).attr('data-col');
					if (colId != "") {
						var col = { id: colId, name: colName, order: index+1};
					} else {
						var col = { name: colName, order: index+1};
					}
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
		}
	});

	$('.cancelForm').on('click', function(e) {
		goTo("projects/" + $("#projectId").val() + "/board");
	});

	$('#editColumnModal .btnUpdate').on('click', function(e) {
		updateCol();
	});

	// === drag and drop ===
	
	initDnd();
	
	$('#editProjectForm').validate({
		rules: {
			// no quoting necessary
			projectName: {required: true}
		},
		messages: {
			projectName: "you must specify a name for your project"
		}
	});
});

var colIdToUpdate="";
function initDnd() {
	$("#dnd .statusLabel").each(function(index, element) {
		$(element).attr('id', 'obj'+index);
		$(element).attr('draggable', 'true');
	});

	$('#dnd').dnd({
		dndContainer : '#dnd',
		dragSelector : '.statusLabel',
		dropSelector : '.dz',
		draggingClass : 'dragPending',
		onEnter : function(obj, event) {grow(obj, "100px");},
		onLeave : function(obj, event) {grow(obj, "10px");},
		onDrop : function(obj, event, id) {$('#'+id).insertAfter($(obj)); refreshDndContainer();},
	});

	refreshDndContainer();
	
	$('#dnd').on('click', '.btn.remove-p', function(){
		$(this).parent().remove();
		refreshDndContainer();
	});

	$('#dnd').on('click', '.btn.edit-p', function(){
		var colName=$(this).closest('.statusLabel').text();
		colIdToUpdate=$(this).closest('.statusLabel').attr('id');
		$('#inputWkfLbl').val(colName);
		$('#inputWkfLbl').focus();
		$('#editColumnModal').modal('show');
	});
	
	$('#dnd').on('click', '.btnAddStatus', function(){
		var idx = $("#dnd .statusLabel").length;
		$('#dnd').append("<div class=\"statusLabel\" id=\"obj"+idx+"\" draggable=\"true\">NEW STEP</div>");
		refreshDndContainer();
	});	
}

function refreshDndContainer() {
	// remove drop zones and buttons
	$('.dz').remove();
	$('.btnAddStatus').remove();
	$('.statusLabel .btn').remove();
	// add drop zone after each draggable element
	$("<div class='dz'></div>").insertAfter('.statusLabel');
	// add button at end of line
	$('#dnd').append("<div class='btnAddStatus'><span class='fa fa-plus'></span></div>");
	// add edit and remove buttons
	$('.statusLabel').append("<div class='btn btn-sm remove-p pull-right'><span class='fa fa-close'></span></div>");
	$('.statusLabel').prepend("<div class='btn btn-sm edit-p pull-left'><span class='fa fa-edit'></span></div>");
}

function grow(obj, size) {
	$(obj).animate({
		width: size,
	}, 150 );
}

function updateCol(){
	$('#'+colIdToUpdate).text($('#inputWkfLbl').val());
	$('#editColumnModal').modal('hide');
	refreshDndContainer();
}

function updateProject(id, name, description, columns, categories) {
	apiProjectsUpdate(
		id, name, description, columns, categories,
		function(data) {
			showAlertSuccess("Project " + name + " updated.");
			goTo("projects/" + id + "/board");
		},
		function(textStatus, errorThrown) {
			showAlertError('Failed to update project ' + name + '.');
		});
}

// End of File