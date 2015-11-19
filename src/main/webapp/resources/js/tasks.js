$(document).ready(function() {
	
	$('#btnCreateTask').on('click', function(e) {
		$('#taskTitle').val("");
		$('#taskDescription').val("");
		$('#taskStatus').val($("#taskStatus option:first").val());
		$('#taskCategory').val("");
		$('#taskAssigned').val("");
		$('#dialogCreateTask').modal('show');
	});

	$('#dialogCreateTask').on('shown.bs.modal', function () {
		$('#taskTitle').focus();
	});
	$('#dialogCreateTask .submitForm').on('click', function(e) {
		createTask(
			$("#projectId").val(),	
			$("#taskTitle").val(),
			replaceAll($("#taskDescription").val(), '\n', '<br>'),
			$("#taskStatus").val(),
			$("#taskCategory").val(),
			$("#taskAssigned").val()
		);
	});

	$('#board').on('click','.btnDeleteTask', function(e) {
		e.stopPropagation();
		deleteTask($(this).closest('.task').attr('data-task'));
	});
	$('#board').on('click','.btnEditTask', function(e) {
		e.stopPropagation();
		var projectId = $("#projectId").val();
		var taskId = $(this).closest('.task').attr('data-task');
		goTo("projects/" + projectId + "/tasks/" + taskId);
	});


	// ajoute la propriété pour le drop et le transfert de données
	$.event.props.push('dataTransfer');
	
	$('.column').on({
		dragstart : function(event) { dragZoneStart(this, event); },
		dragend : function(event) { dragZoneEnd(this, event); }
	}, '.task');
	$('.column').on({
		dragenter : function(event) { event.preventDefault(); dropZoneEnter(this, event); },
		dragleave : function(event) { event.preventDefault(); dropZoneLeave(this, event); },
		dragover : function(event) { event.preventDefault(); return false; },
		dragend : function(event) { event.preventDefault(); dropZoneEnd(this, event); },
		drop : function(event) { event.preventDefault(); dropZoneDrop(this, event); },
	}, '.dropzone');

	updateTasks();
	adaptColumnWidth();
});

function dragZoneStart(obj, event) {
	var data = $(obj).attr('data-task');
	event.dataTransfer.setData("text", data);
	event.dataTransfer.effectAllowed = "move";
	$(obj).addClass('dragPending');
}

function dragZoneEnd(obj, event) {
	$(obj).removeClass('dragPending');
}

function dropZoneDrop(obj, event) {
	var id = event.dataTransfer.getData("text");
	var status = $(obj).closest('.column').attr('data-status');
	dropZoneLeave(obj);
	updateTaskStatus(id, status);
}

function dropZoneEnter(obj, event) {
	$(obj).addClass('dragAllowed');
	animateObj(obj,50);
}

function dropZoneEnd(obj, event) {
	dropZoneLeave(obj);
}

function dropZoneLeave(obj, event) {
	$(obj).removeClass('dragAllowed');
	if ($(obj).hasClass('last-dropzone')) {
		animateObj(obj, 50);
	} else {
		animateObj(obj, 10);
	}
}

function animateObj(obj, objSize){
	$(obj).stop().animate({
		height: objSize
	}, 200);
}

function updateTasks() {
	var projectId = $("#projectId").val();
	$.ajax({
		url : contextPath + "/api/projects/" + projectId + "/tasks"
	}).then(function(data) {
		initColumns();
		var cat = "";
		var elt = "";
		$.each(data, function(index, task) {

			elt = '<div class="task clearfix" data-task="' + task.id + '" draggable="true" >';
			
			elt += '<div class="pull-right">';
			elt += ' <button type="button" class="btnEditTask btn btn-xs btn-default"><span class="fa fa-edit" aria-hidden="true"></span></button>';
			elt += ' <button type="button" class="btnDeleteTask btn btn-xs btn-default"><span class="fa fa-remove" aria-hidden="true"></span></button>';
			elt += '</div>';

			elt += '<div class="task-title">';
			if (task.category != null && task.category !== undefined) {
				elt += task.category.name + '&nbsp;';
				cat = task.category.id;
			} else {
				cat = "";
			}
			elt += '<a>#' + task.id + '</a></div>';

			elt += ' <div class="task-description">' + task.title + '</div>';

			
			elt += '<div class="task-category clearfix">';
			if (task.description != null && task.description !== undefined && task.description != "" ) {
				elt += '<span class="fa fa-align-left pull-left"></span>';
			}
			if (task.user != null && task.user !== undefined) {
				elt += '<span class="pull-right">' + task.user.username + '</span>';
			}
			elt += '</div>';

			elt += '</div>';
			$('.column[data-category="' + cat +'"][data-status="' + task.status.id+'"]').append(elt);
			$('.column[data-category="' + cat +'"][data-status="' + task.status.id+'"]').append('<div class="dropzone"/>');
		});
		$('.column').each(function(index) {
			$(this).find('.dropzone:last-child').addClass('last-dropzone');
		});
		adaptColumnHeight();
	});
}

function initColumns() {
	$('.column').each(function(index) {
		$(this).empty();
		$(this).append('<div class="dropzone">');
	});
}

function createTask(projectId, name, description, status, category, assigned) {
	apiTasksCreate(
		projectId, name, description, status, category, assigned,
		function(data) {
			$('#dialogCreateTask').modal('hide');
			showAlertSuccess("Task created.");
			updateTasks();
		},
		function(textStatus, errorThrown) {
			$('#dialogCreateTask').modal('hide');
			showAlertError("Failed to create task.");
		});
}

function updateTaskStatus(id, status) {
	apiTasksUpdateStatus(
		id, status,
		function(data) {
			updateTasks();
		},
		function(textStatus, errorThrown) {
			updateTasks();
		});
}

function deleteTask(id) {
	apiTaskDelete(
		id,
		function(data) {
			showAlertSuccess("Task deleted.");
			updateTasks();
		},
		function(textStatus, errorThrown) {
			showAlertError("Failed to delete task.");
			updateTasks();
		});
}

function adaptColumnHeight() {
	$(".board-content").each(function(bordIdx, board) {
		var count = 0;
		$(board).find(".column").each(function(index, element) {
			var nbTasks = $(element).find('.task').length;
			if (nbTasks > count) {
				count = nbTasks;
			}
		});
		var size = count * 85 + 50;
		$(board).find(".column").css('height', size+'px');
	});
}

function adaptColumnWidth() {
	var pc = 100 / $('#nbColumns').val();
	$('.board-column').css("width",pc+ '%');	
}