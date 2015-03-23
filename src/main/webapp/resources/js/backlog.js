var usAction = 'create';
//var backlogView = 'refinement';
var backlogView = 'full';

function initPage() {

	// about
	$('.scrum-info').on("click", function(){
		var content = [];
		content.push('The Product Backlog is an ordered list of everything that might be needed in the product and is the single source of requirements for any changes to be made to the product.');
		content.push('The Product Owner is responsible for the Product Backlog, including its content, availability, and ordering.');
		showAboutModal('About product backlog', content, 'The Scrum Guide');
	});
	
	$(".btn-estimate-tool").on("click", function() {
		$('#estimateTool').show();
	});

	$(".btn-us-create").on("click", function() {
		createUSForm();
	});

	$('#form-us').on('submit', function(e) {
		e.preventDefault();
		if (usAction == 'create') {
			createUS();
		} else if (usAction == 'update') {
			editUS();
		}
	});

	$('.cancel-form-us').on("click", function(e) {
		if (backlogView == 'full') {
			$('#modal-us').modal('hide');
			$('#backlogTable').bootstrapTable('refresh', {
				silent : true
			});
		} else {
			displayUS();
		}
	});

	$("#backlogTable").on("click", ".btn-us-edit", function() {
		var usId = $(this).closest(".btn-group").data("usId");
		editUSForm(usId);
	});
	$("#backlogTable").on("click", ".btn-us-remove", function() {
		var usId = $(this).closest(".btn-group").data("usId");
		var usTxt = $(this).closest("tr").find(".codeAndTitle").text();
		removeUS(usId, usTxt);
	});

	$('#modal-removeUS').on('hidden.bs.modal', function(e) {
		// remove event handlers
		$('#form-removeUS').off();
	});

	$("#list-allUS").on("click", "#sortByCode", function() {
		sortUsByCode();
	});
	$("#list-allUS").on("click", "li", function() {
		var usId = $(this).data("usId");
		if (typeof (usId) != 'undefined') {
			$("#list-allUS").find("li").removeClass("active");
			$(this).addClass("active");
			editUSForm(usId);
		}
	});

	$(".switchView").on("click", function() {
		switchView();
	});

	showView();

	activateEstimateTool();
}

function switchView() {
	if (backlogView == 'full') {
		backlogView = 'refinement';
	} else {
		backlogView = 'full';
	}
	showView();
}

function showView() {
	if (backlogView == 'full') {
		$("#modal-us .modal-body").append($("#form-us"));
		$('#backlogTable').bootstrapTable('refresh', {
			silent : true
		});
		$('#refinementView').hide();
		$('#fullView').show();
	} else {
		$("#inlineView").append($("#form-us"));
		displayUS();
		$('#fullView').hide();
		$('#refinementView').show();
		$("#inlineView").hide();
	}
}

function createUSForm() {
	$('#form-us').find('.hiddenInCreation').hide();
	initUSForm('create', 'create an user story', 'create');
	if (backlogView == 'full') {
		$('#modal-us').modal('show');
	} else {
		$("#inlineView").show();
	}
}

function editUSForm(usId) {
	$('#form-us').find('.hiddenInCreation').show();
	startLoading();
	$.getJSON(ajaxPath + '/rest/us/' + usId, function(data) {
		initUSForm('update', 'edit user story', 'update');
		if (typeof (data) != 'undefined') {
			$("#form-us-id").text(data.id);
			$("#form-us-code").val(data.code);
			$("#form-us-title").val(data.title);
			$("#form-us-value").val(data.value);
			$("#form-us-estimate").val(data.estimate);
			$("#form-us-timestamp-creDate").val(data.creationDate);
			$("#form-us-status").val(data.status);
			setTextAreaValue('#form-us-description', data.description);
			setTextAreaValue('#form-us-criteria', data.accCrit);
			setTextAreaValue('#form-us-test', data.accTest);
			setDateTimeValue('#form-us-creDate', data.creationDate);
			setDateTimeValue('#form-us-modDate', data.modificationDate);
		}
		if (backlogView == 'full') {
			$('#modal-us').modal('show');
		} else {
			scrollToTop();
			$("#inlineView").show();
		}
		stopLoading();
	});
}

function initUSForm(action, title, btn, nbRows) {
	usAction = action;
	if (backlogView == 'full') {
		$('#form-us textarea').attr("rows", 3);
	} else {
		$('#form-us textarea').attr("rows", 7);
	}
	$('#modal-us-title').text(title);
	$('#form-us button[type="submit"]').text(btn);
	$("#form-us-id").val("");
	$("#form-us-code").val("");
	$("#form-us-title").val("");
	$("#form-us-value").val("");
	$("#form-us-estimate").val("");
	$("#form-us-status").val("");
	$('#form-us-description').text("");
	$('#form-us-criteria').text("");
	$('#form-us-test').text("");
	$('#form-us-creDate').text("");
	$('#form-us-modDate').text("");
}

function removeUS(usId, usTxt) {
	$('#modal-removeUS .us-title').text(usTxt);
	$('#modal-removeUS').modal('show');
	$('#form-removeUS').on('submit', function(e) {
		e.preventDefault();
		var us = {
			id : usId
		};
		usDelete(us, function(html) {
			$('#modal-removeUS').modal('hide');
			$('#backlogTable').bootstrapTable('refresh', {
				silent : true
			});
		});
	});
}

function createUS() {
	var us = {
		code : $("#form-us-code").val(),
		title : $("#form-us-title").val(),
		desc : getTextAreaValue('#form-us-description'),
		crit : getTextAreaValue('#form-us-criteria'),
		test : getTextAreaValue('#form-us-test'),
		value : $("#form-us-value").val(),
		estimate : $("#form-us-estimate").val(),
		status : $("#form-us-status").val(),
	};

	usCreate(us, function(html) {
		$('#form-us')[0].reset();
		if (backlogView == 'full') {
			$('#modal-us').modal('hide');
			$('#backlogTable').bootstrapTable('refresh', {
				silent : true
			});
		} else {
			displayUS();
		}
	});
}

function editUS() {
	var us = {
		id : $("#form-us-id").text(),
		code : $("#form-us-code").val(),
		title : $("#form-us-title").val(),
		desc : getTextAreaValue('#form-us-description'),
		crit : getTextAreaValue('#form-us-criteria'),
		test : getTextAreaValue('#form-us-test'),
		creDate : $("#form-us-timestamp-creDate").val(),
		value : $("#form-us-value").val(),
		estimate : $("#form-us-estimate").val(),
		status : $("#form-us-status").val(),
	};

	usUpdate(us, function(html) {
		$('#form-us')[0].reset();
		if (backlogView == 'full') {
			$('#modal-us').modal('hide');
			$('#backlogTable').bootstrapTable('refresh', {
				silent : true
			});
		} else {
			displayUS();
		}
	});
}

var sortOrder = 'asc';
var sortOrderClass = '';

var sortCodeClass = "showCaret";
var sortModClass = "hideCaret";

function sortUsByCode() {
	sortCodeClass = "showCaret";
	if (sortOrder == 'asc') {
		sortOrder = "desc";
		sortOrderClass = "dropup";
	} else {
		sortOrder = 'asc';
		sortOrderClass = '';
	}
	displayUS();
}

function displayUS() {
	$("#list-allUS").empty();
	startLoading();
	$.getJSON(ajaxPath + '/rest/us?sort=code&order=' + sortOrder, function(data) {
		if (data.length > 0) {
			var elt = '<li class="list-group-item"><div id="sortByCode" class="list-table-cell">[code] title &amp; description<span class="'
					+ sortOrderClass
					+ ' '
					+ sortCodeClass
					+ '"><span class="caret" style="margin:10px 5px;"></span></span></div></li>';
			$.each(data, function(i, us) {
				elt += '<li class="list-group-item" data-us-id="'
					+ us.id
					+ '"><div class="list-table-cell">'
				if (typeof (us.code) != 'undefined' && us.code != '') {
					elt += '[' + us.code + '] ';
				}
				elt += us.title + '</div></li>';
			});
			$("#list-allUS").append(elt);
		}
		$("#inlineView").hide();
		stopLoading();
	});
}