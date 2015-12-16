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

	initDnd();

	updateTasks();
	adaptColumnWidth();
});

function initDnd() {
	var dragCategory = 0;
	$('.board-content').dnd({
		attributeSelector : 'data-task',
		dndContainer : '.board-content',
		dragSelector : '.task',
		dropSelector : '.column',
		draggingClass : 'dragPending',
		onStart : function(obj, event) {
			dragCategory = $(obj).closest('.column').attr('data-category');
		},
		onEnter : function(obj, event) {
			var cat = $(obj).closest('.column').attr('data-category');
			if (dragCategory==cat) {
				$(obj).addClass('dragAllowed');
			} else {
				$(obj).addClass('dragNotAllowed');
			}
		},
		onLeave : function(obj, event) {
			$(obj).removeClass('dragAllowed');
			$(obj).removeClass('dragNotAllowed');
		},
		onDrop : function(obj, event, id) {
			var cat = $(obj).closest('.column').attr('data-category');
			var status = $(obj).closest('.column').attr('data-status');
			if (dragCategory==cat) {
				updateTaskStatus(id, status);
			}
		},
	});
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
			
			elt += '<div class="dropdown pull-right">';
			elt += '<button class="btn btn-xs btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true"><span class="caret"></span></button><ul class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenu1"><li><a class="btnDeleteTask">remove</a></li></ul>';
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