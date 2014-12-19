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

		<div id="backlogTable-toolbar" class="bsTableToolbar">
			<span class="title">product backlog</span>
			<a class="scrum-info" data-toggle="modal" data-target="#aboutProductBacklog"><span class="glyphicon glyphicon-info-sign"></span></a>
			<div class="btn-group">
				<button id="btn-us-create" type="button" class="btn btn-default">create new user story</button>
			</div>
		</div>
		<table id="backlogTable" class="bsTable table table-hover table-condensed" data-toggle="table" data-url="rest/us" data-cache="false" data-toolbar="#backlogTable-toolbar" data-sort-name="code" data-sort-order="asc" data-search="true" data-show-refresh="true" data-show-columns="true">
			<thead>
				<tr>
					<th data-field="code" class="col-md-3" data-formatter="codeTitleFormatter" data-sortable="true">[code] title &amp; description</th>
					<th data-field="accCrit" class="col-md-3">acceptance criteria</th>
					<th data-field="accTest" class="col-md-3">acceptance tests</th>
					<th data-field="creationDate" class="col-md-1" data-formatter="dateFormatter" data-visible="false" data-sortable="true" data-halign="center" data-align="center">creation date</th>
					<th data-field="modificationDate" class="col-md-1" data-formatter="dateFormatter" data-sortable="true" data-halign="center" data-align="center">modification date</th>
					<th data-formatter="actionFormatter" class="col-md-1" data-halign="center" data-align="center">action</th>
				</tr>
			</thead>
		</table>

	</div> <!-- /.container-fluid -->

	<div id="modal-us" class="modal fade">
		<div class="modal-dialog modal-lg" role="dialog" aria-labelledby="modal-us-title" aria-hidden="true">
			<div class="modal-content">
				<div class="modal-header">
					<h4 id="modal-us-title" class="modal-title"></h4>
				</div>
				<div class="modal-body">
					<form id="form-us" class="form-horizontal" role="form">
						<span id="form-us-id" class="hidden"></span>
						<div class="form-group">
							<label for="form-us-code" class="col-sm-3 control-label">code</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id="form-us-code">
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
						<div class="form-group">
							<label class="col-sm-3 control-label">creation date</label>
							<div class="col-sm-9">
								<p id="form-us-creDate" class="form-control-static"></p>
								<input type="hidden" id="form-us-timestamp-creDate">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">modification date</label>
							<div class="col-sm-9">
								<p id="form-us-modDate" class="form-control-static"></p>
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-offset-3 col-sm-9 text-right">
								<button type="button" class="btn btn-default" data-dismiss="modal">cancel</button>
								<button type="submit" class="btn btn-primary"></button>
							</div>
						</div>
					</form>
				</div>
			</div> <!-- /.modal-content -->
		</div> <!-- /.modal-dialog -->
	</div> <!-- /.modal -->

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
					<p></p>
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

	$(document).ready(function() {
		setAjaxPath('${pageContext.request.contextPath}');
		initPage();
	});

	function initPage() {

		$("#btn-us-create").on("click", function() {
			createUSForm();
		});

		$('#form-us').on('submit', function(e) {
			e.preventDefault();
			if (usAction == 'create') {
				createUS();
			} else if (usAction == 'update') {
				editUS();
			} else {
				$('#modal-us').modal('hide');
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

	}
	
	function createUSForm() {
		$('#form-us-creDate').text("");
		$('#form-us-creDate').closest(".form-group").hide();
		$('#form-us-modDate').text("");
		$('#form-us-modDate').closest(".form-group").hide();
		initUSForm('create', 'create an user story', 'create');
		$('#modal-us').modal('show');
	}

	function editUSForm(usId) {
		$('#form-us')[0].reset();
		$('#form-us-creDate').closest(".form-group").show();
		$('#form-us-modDate').closest(".form-group").show();
	    $.getJSON('${pageContext.request.contextPath}/rest/us/' + usId,	function(data) {
	    	if (typeof(data) != 'undefined') {
	    		$("#form-us-id").text(data.id);
	    		$("#form-us-code").val(data.code);
	    		$("#form-us-title").val(data.title);
	    		$("#form-us-timestamp-creDate").val(data.creationDate);
	    		setTextAreaValue('#form-us-description', data.description);
	    		setTextAreaValue('#form-us-criteria', data.accCrit);
	    		setTextAreaValue('#form-us-test', data.accTest);
	    		setDateTimeValue('#form-us-creDate', data.creationDate);
	    		setDateTimeValue('#form-us-modDate', data.modificationDate);
	    	}
			initUSForm('update', 'edit user story', 'update');
			$('#modal-us').modal('show');
		});
	}

	function initUSForm(action, title, btn) {
		usAction = action;
		$('#modal-us-title').text(title);
		$('#form-us button[type="submit"]').text(btn);
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
			 test: getTextAreaValue('#form-us-test')
		};

		usCreate(us, function(html) {
			$('#form-us')[0].reset();
			$('#modal-us').modal('hide');
			$('#backlogTable').bootstrapTable('refresh', {silent: true});
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
			creDate: $("#form-us-timestamp-creDate").val()
		};

		usUpdate(us, function(html) {
			$('#form-us')[0].reset();
			$('#modal-us').modal('hide');
			$('#backlogTable').bootstrapTable('refresh', {silent: true});
		});
	}

	</script>

</body>
</html>