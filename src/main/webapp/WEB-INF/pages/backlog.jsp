<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="Sopra Group">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
<title>scarab</title>
<link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/bootstrap-table.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/scarab.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/backlog.css" rel="stylesheet">
</head>

<body>

	<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
		<div class="container-fluid">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-links">
					<span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="${pageContext.request.contextPath}">Scarab</a>
			</div>
			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse" id="navbar-links">
				<ul class="nav navbar-nav navbar-right">
					<li><a data-toggle="modal" data-target="#aboutScarab"><span class="glyphicon glyphicon-question-sign"></span></a></li>
				</ul>
				<ul class="nav navbar-nav">
					<li class="active"><a href="${pageContext.request.contextPath}/backlog">product backlog</a></li>
					<li><a href="${pageContext.request.contextPath}/sprint">sprint planning</a></li>
					<li><a href="${pageContext.request.contextPath}/daily">daily scrum</a></li>
					<li><a href="${pageContext.request.contextPath}/review">sprint review</a></li>
					<li><a href="${pageContext.request.contextPath}/retro">sprint retrospective</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<div class="container-fluid">

		<div id="fullView">
			<div id="backlogTable-toolbar" class="bsTableToolbar">
				<span class="title">product backlog</span>
				<a class="scrum-info" data-toggle="modal" data-target="#aboutProductBacklog"><span class="glyphicon glyphicon-info-sign"></span></a>
				<div class="btn-group">
					<button type="button" class="switchView btn btn-default"><span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>&nbsp;refinement view</button>
					<button type="button" class="btn-us-create btn btn-primary">create new user story</button>
				</div>
			</div>
			<table id="backlogTable" class="bsTable table table-hover table-condensed" data-toggle="table" data-url="rest/us" data-cache="false" data-toolbar="#backlogTable-toolbar" data-sort-name="code" data-sort-order="asc" data-search="true" data-show-refresh="true" data-show-columns="true">
				<thead>
					<tr>
						<th data-field="code" class="col-md-2" data-formatter="codeTitleFormatter" data-sortable="true">[code] title &amp; description</th>
						<th data-field="value" class="col-md-1" data-sortable="true" data-halign="center" data-align="center">value</th>
						<th data-field="accCrit" class="col-md-2">acceptance criteria</th>
						<th data-field="accTest" class="col-md-2">acceptance tests</th>
						<th data-field="creationDate" class="col-md-1" data-formatter="dateFormatter" data-visible="false" data-sortable="true" data-halign="center" data-align="center">creation date</th>
						<th data-field="modificationDate" class="col-md-1" data-formatter="dateFormatter" data-sortable="true" data-halign="center" data-align="center">last update</th>
						<th data-formatter="actionFormatter" class="col-md-1" data-halign="center" data-align="center">action</th>
					</tr>
				</thead>
			</table>
		</div>

		<div id="refinementView">
			<div class="fixed-table-toolbar">
				<div class="bars pull-left">
					<div class="bsTableToolbar">
						<span class="title">product backlog</span>
						<a class="scrum-info" data-toggle="modal" data-target="#aboutProductBacklog"><span class="glyphicon glyphicon-info-sign"></span></a>
						<div class="btn-group">
							<button type="button" class="switchView btn btn-default"><span class="glyphicon glyphicon-eye-close" aria-hidden="true"></span>&nbsp;full view</button>
							<button type="button" class="btn-us-create btn btn-primary">create new user story</button>
						</div>
					</div>
				</div>
			</div>
			<div class="row" style="clear:both;">
				<div class="col-md-3">
					<ul id="list-allUS" class="list-group"></ul>
				</div>
				<div class="col-md-6">
					<div id="inlineView"></div>
				</div>
			</div>
		</div>

	</div> <!-- /.container-fluid -->

	<div id="modal-us" class="modal fade">
		<div class="modal-dialog modal-lg" role="dialog" aria-labelledby="modal-us-title" aria-hidden="true">
			<div class="modal-content">
				<div class="modal-header">
					<h4 id="modal-us-title" class="modal-title"></h4>
				</div>
				<div class="modal-body"></div>
			</div> <!-- /.modal-content -->
		</div> <!-- /.modal-dialog -->
	</div> <!-- /.modal -->

	<form id="form-us" class="form-horizontal" role="form">
		<span id="form-us-id" class="hidden"></span>
		<div class="form-group">
			<label for="form-us-code" class="col-sm-3 control-label">code</label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="form-us-code">
			</div>
			<div class="col-sm-2">
				<div class="input-group">
					<span class="input-group-addon"><span class="glyphicon glyphicon-usd" aria-hidden="true"></span></span>
					<input type="number" min="1" class="form-control" id="form-us-value">
				</div>
			</div>
			<div class="col-sm-2">
				<div class="input-group">
					<span class="input-group-addon"><span class="glyphicon glyphicon-cog" aria-hidden="true"></span></span>
					<input type="text" class="form-control" id="form-us-estimate">
				</div>
			</div>
		</div>
		<div class="form-group">
			<label for="form-us-title" class="col-sm-3 control-label">title</label>
			<div class="col-sm-9">
				<input type="text" class="form-control" id="form-us-title" required>
			</div>
		</div>
		<div class="form-group">
			<label for="form-us-description" class="col-sm-3 control-label">description</label>
			<div class="col-sm-9">
				<textarea id="form-us-description" class="form-control" rows="3"></textarea>
			</div>
		</div>
		<div class="form-group">
			<label for="form-us-criteria" class="col-sm-3 control-label">acceptance criteria</label>
			<div class="col-sm-9">
				<textarea id="form-us-criteria" class="form-control" rows="3"></textarea>
			</div>
		</div>
		<div class="form-group">
			<label for="form-us-test" class="col-sm-3 control-label">acceptance tests</label>
			<div class="col-sm-9">
				<textarea id="form-us-test" class="form-control" rows="3"></textarea>
			</div>
		</div>
		<div class="form-group hiddenInCreation">
			<label class="col-sm-3 control-label">dates</label>
			<div class="col-sm-9">
				<label class="col-sm-3 control-label">creation</label>
				<div class="col-sm-9">
					<p id="form-us-creDate" class="form-control-static"></p>
					<input type="hidden" id="form-us-timestamp-creDate">
				</div>
				<label class="col-sm-3 control-label">last update</label>
				<div class="col-sm-9">
					<p id="form-us-modDate" class="form-control-static"></p>
				</div>
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-3 col-sm-9 text-right">
				<button type="button" class="cancel-form-us btn btn-default">cancel</button>
				<button type="submit" class="btn btn-primary"></button>
			</div>
		</div>
	</form>

	<div id="modal-removeUS" class="modal fade">
		<div class="modal-dialog" role="dialog" aria-labelledby="modal-removeUS-title" aria-hidden="true">
			<div class="modal-content">
				<div class="modal-header">
					<h4 id="modal-removeUS-title" class="modal-title">Remove User Story</h4>
				</div>
				<div class="modal-body">
					<form id="form-removeUS" role="form">
						<div class="form-group">
							<p>Are you sure you want to remove user story "<span class="us-title"></span>" ?</p>
						</div>
						<div class="form-group clearfix">
							<div class="col-xs-12 text-right">
								<button type="button" class="btn btn-default" data-dismiss="modal">cancel</button>
								<button type="submit" class="btn btn-danger">remove</button>
							</div>
						</div>
					</form>
				</div>
			</div> <!-- /.modal-content -->
		</div> <!-- /.modal-dialog -->
	</div> <!-- /.modal -->

	<div id="aboutProductBacklog" class="modal fade">
		<div class="modal-dialog modal-lg" role="dialog" aria-labelledby="modal-productBacklog-title" aria-hidden="true">
			<div class="modal-content">
				<div class="modal-header">
					<h4 id="modal-productBacklog-title" class="modal-title">About product backlog</h4>
				</div>
				<div class="modal-body">
					<blockquote>
					<p>The Product Backlog is an ordered list of everything that might be needed in the product and is the single source of requirements for any changes to be made to the product. The Product Owner is responsible for the Product Backlog, including its content, availability, and ordering.</p>
					<footer>The Scrum Guide</footer>
					</blockquote>
				</div>
			</div>
		</div>
	</div>

	<!-- Placed at the end of the document so the pages load faster -->
	<script src="${pageContext.request.contextPath}/resources/js/libs/jquery-1.11.0.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/libs/bootstrap.min.js"></script>

	<script src="${pageContext.request.contextPath}/resources/js/about.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/common.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/userStory.js"></script>

	<script src="${pageContext.request.contextPath}/resources/js/libs/bootstrap-table.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/backlogTable.js"></script>

	<script type="text/javascript">

	var usAction = 'create';
	var backlogView = 'refinement';

	$(document).ready(function() {
		setAjaxPath('${pageContext.request.contextPath}');
		initPage();
	});

	function initPage() {

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
				$('#backlogTable').bootstrapTable('refresh', {silent: true});
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

		$('#modal-removeUS').on('hidden.bs.modal', function (e) {
			// remove event handlers
			$('#form-removeUS').off();
		});
	
		$("#list-allUS").on("click", "#sortByCode", function() {
			sortUsByCode();
		});
		$("#list-allUS").on("click", "li", function() {
			$("#list-allUS").find("li").removeClass("active");
			$(this).addClass("active");
			var usId = $(this).data("usId");
			editUSForm(usId);
		});
		
		$(".switchView").on("click",  function() {
			switchView();
		});
		 
		showView();
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
			$('#backlogTable').bootstrapTable('refresh', {silent: true});
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
	    $.getJSON('${pageContext.request.contextPath}/rest/us/' + usId,	function(data) {
			initUSForm('update', 'edit user story', 'update');
	    	if (typeof(data) != 'undefined') {
	    		$("#form-us-id").text(data.id);
	    		$("#form-us-code").val(data.code);
	    		$("#form-us-title").val(data.title);
	    		$("#form-us-value").val(data.value);
	    		$("#form-us-timestamp-creDate").val(data.creationDate);
	    		setTextAreaValue('#form-us-description', data.description);
	    		setTextAreaValue('#form-us-criteria', data.accCrit);
	    		setTextAreaValue('#form-us-test', data.accTest);
	    		setDateTimeValue('#form-us-creDate', data.creationDate);
	    		setDateTimeValue('#form-us-modDate', data.modificationDate);
	    	}
			if (backlogView == 'full') {
				$('#modal-us').modal('show');
			} else {
				$("#inlineView").show();
			}
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
		$('#form-us-description').text("");;
		$('#form-us-criteria').text("");;
		$('#form-us-test').text("");;
		$('#form-us-creDate').text("");
		$('#form-us-modDate').text("");
	}

	function removeUS(usId, usTxt) {
		$('#modal-removeUS .us-title').text(usTxt);
		$('#modal-removeUS').modal('show');
		$('#form-removeUS').on('submit', function(e) {
			e.preventDefault();
			var us= { id: usId };
			usDelete(us, function(html) {
				$('#modal-removeUS').modal('hide');
				$('#backlogTable').bootstrapTable('refresh', {silent: true});
			});
        });
	}

	function createUS() {
		var us= {
			code: $("#form-us-code").val(),
			title: $("#form-us-title").val(),
			desc: getTextAreaValue('#form-us-description'),
			crit: getTextAreaValue('#form-us-criteria'),
			test: getTextAreaValue('#form-us-test'),
			value: $("#form-us-value").val()
		};

		usCreate(us, function(html) {
			$('#form-us')[0].reset();
			if (backlogView == 'full') {
				$('#modal-us').modal('hide');
				$('#backlogTable').bootstrapTable('refresh', {silent: true});
			} else {
				displayUS();
			}
		});
	}
	
	function editUS() {
		var us= {
			id: $("#form-us-id").text(),
			code: $("#form-us-code").val(),
			title: $("#form-us-title").val(),
			desc: getTextAreaValue('#form-us-description'),
			crit: getTextAreaValue('#form-us-criteria'),
			test: getTextAreaValue('#form-us-test'),
			creDate: $("#form-us-timestamp-creDate").val(),
			value: $("#form-us-value").val()
		};

		usUpdate(us, function(html) {
			$('#form-us')[0].reset();
			if (backlogView == 'full') {
				$('#modal-us').modal('hide');
				$('#backlogTable').bootstrapTable('refresh', {silent: true});
			} else {
				displayUS();
			}
		});
	}

	var sortOrder='asc';
	var sortOrderClass='';

	var sortCodeClass="showCaret";
	var sortModClass="hideCaret";

	function sortUsByCode() {
		sortCodeClass="showCaret";
		if (sortOrder == 'asc') {
			sortOrder="desc";
			sortOrderClass="dropup";
		} else {
			sortOrder='asc';
			sortOrderClass='';
		}
		displayUS();
	}

	function displayUS() {
	    $.getJSON('${pageContext.request.contextPath}/rest/us?sort=code&order=' + sortOrder,	function(data) {
			$("#list-allUS").empty();
		   	if (data.length > 0) {
		   		var elt = '<li class="list-group-item"><div id="sortByCode" class="list-table-cell">[code] title &amp; description<span class="' + sortOrderClass + ' ' + sortCodeClass + '"><span class="caret" style="margin:10px 5px;"></span></span></div></li>';
		   		$.each(data, function(i, us) {
		   			elt += '<li class="list-group-item" data-us-id="' + us.id + '"><div class="list-table-cell">'
		   				+   '<div class="list-group-item-heading">';
		   			 if (typeof(us.code) != 'undefined' && us.code != '') {
		    			 elt += '[' + us.code + '] ';
		   			 }
		   			 elt += us.title
		   			 	+   '</div>'
		   			 	+   '<div class="list-group-item-text">' + us.description + '</div>'
		   			 	+ '</div></li>';
		   		});
	    		$("#list-allUS").append(elt);
		   	}
			$("#inlineView").hide();
	    });
	}
	</script>

</body>
</html>