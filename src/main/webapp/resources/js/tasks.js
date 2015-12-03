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

//	var dragCategory = 0;
//	myFeature.init({
//		dndContainer : '.board-content',
//		dragSelector : '.task',
//		dropSelector : '.column',
//		draggingClass : 'dragPending',
//		onStart : function(obj, event) {
//			dragCategory = $(obj).closest('.column').attr('data-category');
//		},
//		onEnter : function(obj, event) {
//			var cat = $(obj).closest('.column').attr('data-category');
//			if (dragCategory==cat) {
//				$(obj).addClass('dragAllowed');
//			} else {
//				$(obj).addClass('dragNotAllowed');
//			}
//		},
//		onLeave : function(obj, event) {
//			$(obj).removeClass('dragAllowed');
//			$(obj).removeClass('dragNotAllowed');
//		},
//		onDrop : function(obj, event, id) {
//			var cat = $(obj).closest('.column').attr('data-category');
//			var status = $(obj).closest('.column').attr('data-status');
//			if (dragCategory==cat) {
//				updateTaskStatus(id, status);
//			}
//		},
//	});

	// ajoute la propriété pour le drop et le transfert de données
	$.event.props.push('dataTransfer');
	
	$('.column').on({
		dragstart : function(event) { dragZoneStart(this, event); },
		dragend : function(event) { dragZoneEnd(this, event); }
	}, '.task');
	$('.board-content').on({
		dragenter : function(event) { event.preventDefault(); dropZoneEnter(this, event); },
		dragleave : function(event) { event.preventDefault(); dropZoneLeave(this, event); },
		dragover : function(event) { event.preventDefault(); return false; },
		dragend : function(event) { event.preventDefault(); dropZoneEnd(this, event); },
		drop : function(event) { event.preventDefault(); dropZoneDrop(this, event); },
	}, '.column');

	updateTasks();
	adaptColumnWidth();
});

var dragCategory = 0;
function dragZoneStart(obj, event) {
	var data = $(obj).attr('data-task');
	event.dataTransfer.setData("text", data);
	event.dataTransfer.effectAllowed = "move";
	
	dragCategory = $(obj).closest('.column').attr('data-category');

	$(obj).addClass('dragPending');
}

function dragZoneEnd(obj, event) {
	$(obj).removeClass('dragPending');
}

function dropZoneDrop(obj, event) {
	var id = event.dataTransfer.getData("text");
	var cat = $(obj).closest('.column').attr('data-category');
	var status = $(obj).closest('.column').attr('data-status');
	dropZoneLeave(obj);
	if (dragCategory==cat) {
		updateTaskStatus(id, status);
	}
}

function dropZoneEnter(obj, event) {
	var cat = $(obj).closest('.column').attr('data-category');
	if (dragCategory==cat) {
		$(obj).addClass('dragAllowed');
	} else {
		$(obj).addClass('dragNotAllowed');
	}
}

function dropZoneEnd(obj, event) {
	dropZoneLeave(obj);
}

function dropZoneLeave(obj, event) {
	$(obj).removeClass('dragAllowed');
	$(obj).removeClass('dragNotAllowed');
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
			elt += ' <button type="button" class="btnDeleteTask btn btn-xs btn-default"><span class="fa fa-remove" aria-hidden="true"></span></button>';
			elt += '</div>';

			elt += '<div class="task-title">';
			if (task.category != null && task.category !== undefined) {
				elt += task.category.name + '&nbsp;';
				cat = task.category.id;
			} else {
				cat = "";
			}
			elt += '<a href="' + contextPath + '/projects/' + projectId + '/tasks/' + task.id + '">#' + task.id + '</a></div>';

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
		});
		adaptColumnHeight();
	});
}

function initColumns() {
	$('.column').each(function(index) {
		$(this).empty();
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
		var count = 1;
		$(board).find(".column").each(function(index, element) {
			var nbTasks = $(element).find('.task').length;
			if (nbTasks > count) {
				count = nbTasks;
			}
		});
		var size = count * 85 + 10;
		$(board).find(".column").css('height', size+'px');
	});
}

function adaptColumnWidth() {
	var pc = 100 / $('#nbColumns').val();
	$('.board-column').css("width",pc+ '%');	
}