$(document).ready(function() {
//	$('div.form-group-options').on('focus', 'div.input-group-option:last-child input', function(){
//		var sInputGroupHtml = $(this).parent().html();
//		var sInputGroupClasses = $(this).parent().attr('class');
//		$(this).parent().parent().append('<div class="'+sInputGroupClasses+'">'+sInputGroupHtml+'</div>');
//	});
	
	$('div.form-group-options').on('click', '.input-group-addon-remove', function(){
		$(this).parent().remove();
	});

	$('#inputValue').val("");
	
	var defaultColumns = [ "BACKLOG", "TODO", "PENDING", "DONE" ];
	$("#dnd .p").each(function(index, element) {
		$(element).attr('id', 'obj'+index);
		$(element).attr('draggable', 'true');
		$(element).text(defaultColumns[index]);
	});

	var defaultCategory = [ "ANOMALIE", "EVOLUTION" ];
	$("[name=category\\[\\]]").each(function(index, element) {
		$(element).val(defaultCategory[index]);
	});

	$('#inputValue').focus();

	$('#dnd').on('click', '.btn.remove-p', function(){
		$(this).parent().remove();
		initDnd();
	});

	$('#dnd').on('click', '.b', function(){
		var idx = $("#dnd .p").length;
		$('#dnd').append("<div class=\"p\" id=\"obj"+idx+"\" draggable=\"true\">NEW STEP</div>");
		initDnd();
	});

	$('.submitForm').on('click', function(e) {
		
		var columns = [];
		$("#dnd .p").each(function(index, element) {
			var colName = $(element).text();
			if (colName != "") {
				var col = { name: colName, order: index+1};
				columns.push(col);
			}
		});

		var categories = [];
		$("[name=category\\[\\]]").each(function(index, element) {
			categories.push($(element).val());
		});

		createProject($('#inputValue').val(), columns, categories, replaceAll($("#projectDescription").val(), '\n', '<br>'));
	});

	$('.cancelForm').on('click', function(e) {
		goTo("");
	});

	// === drag and drop ===
	
	initDnd();
	// ajoute la propriété pour le drop et le transfert de données
	$.event.props.push('dataTransfer');
	$('#dnd').on({
		dragstart : function(event) { dragZoneStart(this, event); },
		dragend : function(event) { dragZoneEnd(this, event); }
	}, '.p');
	$('#dnd').on({
		dragenter : function(event) { event.preventDefault(); dropZoneEnter(this, event); },
		dragleave : function(event) { event.preventDefault(); dropZoneLeave(this, event); },
		dragover : function(event) { event.preventDefault(); return false; },
		dragend : function(event) { event.preventDefault(); dropZoneEnd(this, event); },
		drop : function(event) { event.preventDefault(); dropZoneDrop(this, event); },
	}, '.d');

});

function initDnd() {
	// remove drop zones and buttons
	$('.d').remove();
	$('.b').remove();
	$('.p .btn').remove();
	// add fist drop zone
	// $('#dnd').prepend("<div class='d'></div>");
	// add drop zone after each draggable element
	$("<div class='d'></div>").insertAfter('.p');
	// add button at end of line
	$('#dnd').append("<div class=\"b\" ><span class=\"fa fa-plus\"></span></div>");
	// add edit and remove buttons
	$('.p').append("<div class=\"btn btn-sm remove-p pull-right\" ><span class=\"fa fa-close\"></span></div>");
	$('.p').prepend("<div class=\"btn btn-sm edit-p pull-left\" ><span class=\"fa fa-edit\"></span></div>");
}

function dragZoneStart(obj, event) {
	var data = $(obj).attr('id');
	event.dataTransfer.setData("text", data);
	event.dataTransfer.effectAllowed = "move";
	$(obj).addClass('dragPending');
}

function dragZoneEnd(obj, event) {
	$(obj).removeClass('dragPending');
}

function dropZoneDrop(obj, event) {
	var id = event.dataTransfer.getData("text");
	$('#'+id).insertAfter($(obj));
	dropZoneLeave(obj);
	initDnd();
}

function dropZoneEnter(obj, event) {
	grow(obj, "50px");
}

function dropZoneEnd(obj, event) {
	dropZoneLeave(obj);
}

function dropZoneLeave(obj, event) {
	grow(obj, "10px");
}

function grow(obj, size) {
	$(obj).animate({
		width: size,
	}, 150 );
}

function createProject(name, columns, categories, description) {
	apiProjectsCreate(
		name, columns, categories, description,
		function(data) {
			showAlertSuccess("Project " + name + " created.");
			goTo("");
		},
		function(jqXHR, textStatus, errorThrown) {
			var errorMessage = 'Can not create project.';
			if (jqXHR.status == 400) {
				errorMessage += "<br>Invalid configuration";
			} else if (jqXHR.status == 500) {
				errorMessage += "<br>Server error";
			}
			showAlertError(errorMessage);
		});
}

// End of File