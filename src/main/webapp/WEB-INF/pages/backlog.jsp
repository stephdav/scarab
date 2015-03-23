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
					<li><a id="about-scarab"><span class="glyphicon glyphicon-question-sign"></span></a></li>
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
				<span class="title">product backlog</span>&nbsp;<a class="scrum-info"><span class="glyphicon glyphicon-info-sign"></span></a>
				<div class="btn-group">
					<button type="button" class="switchView btn btn-default"><span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>&nbsp;refinement view</button>
					<button type="button" class="btn-us-create btn btn-primary">create new user story</button>
				</div>
			</div>
			<table id="backlogTable" class="bsTable table table-hover table-condensed" data-toggle="table" data-url="rest/us" data-cache="false" data-toolbar="#backlogTable-toolbar" data-sort-name="code" data-sort-order="asc" data-search="true" data-show-refresh="true" data-show-columns="true">
				<thead>
					<tr>
						<th data-field="code" class="colTab20" data-formatter="codeTitleFormatter" data-sortable="true">[code] title &amp; description</th>
						<th data-field="accCrit" class="colTab20">acceptance criteria</th>
						<th data-field="accTest" class="colTab20" data-visible="false" >acceptance tests</th>
						<th data-field="value" class="colTab50" data-sortable="true" data-halign="center" data-align="center"><span class="glyphicon glyphicon-usd" title="value" aria-hidden="true"></span></th>
						<th data-field="estimate" class="colTab50" data-sortable="true" data-halign="center" data-align="center"><span class="glyphicon glyphicon-cog" title="estimate" aria-hidden="true"></span></th>
						<th data-field="status" class="colTab20" data-formatter="statusFormatter" data-sortable="true" data-halign="center" data-align="center">status</th>
						<th data-field="creationDate" class="colTab125" data-formatter="dateFormatter" data-visible="false" data-sortable="true" data-halign="center" data-align="center">creation date</th>
						<th data-field="modificationDate" class="colTab125" data-formatter="dateFormatter" data-visible="false" data-sortable="true" data-halign="center" data-align="center">last update</th>
						<th data-formatter="actionFormatter" class="colTab100" data-halign="center" data-align="center">action</th>
					</tr>
				</thead>
			</table>
		</div>

		<div id="refinementView">
			<div class="fixed-table-toolbar">
				<div class="bars pull-left">
					<div class="bsTableToolbar">
						<span class="title">product backlog</span>&nbsp;<a class="scrum-info"><span class="glyphicon glyphicon-info-sign"></span></a>
						<div class="btn-group">
							<button type="button" class="switchView btn btn-default"><span class="glyphicon glyphicon-eye-close" aria-hidden="true"></span>&nbsp;full view</button>
							<button type="button" class="btn-us-create btn btn-primary">create new user story</button>
						</div>
					</div>
				</div>
				<div class="bars btn-group pull-right">
					<button type="button" class="btn-estimate-tool btn btn-default" title="estimate tool"><span class="glyphicon glyphicon-cog" aria-hidden="true"></span></button>
				</div>
			</div>
			<div class="row" style="clear:both;">
				<div class="col-md-3">
					<ul id="list-allUS" class="list-group"></ul>
				</div>
				<div class="col-md-7">
					<div id="inlineView"></div>
				</div>
				<div class="col-md-2">
					<div id="estimateTool" style="display:none;">
								<table class="table table-bordered table-condensed">
									<thead>
										<tr class="voteTool"><td class="vtEstimate" width="60px">estimate</td><td class="vtEstimate">votes</td></tr>
									</thead>
									<tbody>
										<tr class="voteTool"><td class="vtEstimate">0</td><td><div><div class="vtMinus"><span class="glyphicon glyphicon-minus" aria-hidden="true"></span></div><div class="vtContent">0</div><div class="vtPlus"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span></div></div></td></tr>
										<tr class="voteTool"><td class="vtEstimate">1</td><td><div><div class="vtMinus"><span class="glyphicon glyphicon-minus" aria-hidden="true"></span></div><div class="vtContent">0</div><div class="vtPlus"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span></div></div></td></tr>
										<tr class="voteTool"><td class="vtEstimate">2</td><td><div><div class="vtMinus"><span class="glyphicon glyphicon-minus" aria-hidden="true"></span></div><div class="vtContent">0</div><div class="vtPlus"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span></div></div></td></tr>
										<tr class="voteTool"><td class="vtEstimate">3</td><td><div><div class="vtMinus"><span class="glyphicon glyphicon-minus" aria-hidden="true"></span></div><div class="vtContent">0</div><div class="vtPlus"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span></div></div></td></tr>
										<tr class="voteTool"><td class="vtEstimate">5</td><td><div><div class="vtMinus"><span class="glyphicon glyphicon-minus" aria-hidden="true"></span></div><div class="vtContent">0</div><div class="vtPlus"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span></div></div></td></tr>
										<tr class="voteTool"><td class="vtEstimate">8</td><td><div><div class="vtMinus"><span class="glyphicon glyphicon-minus" aria-hidden="true"></span></div><div class="vtContent">0</div><div class="vtPlus"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span></div></div></td></tr>
										<tr class="voteTool"><td class="vtEstimate">13</td><td><div><div class="vtMinus"><span class="glyphicon glyphicon-minus" aria-hidden="true"></span></div><div class="vtContent">0</div><div class="vtPlus"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span></div></div></td></tr>
										<tr class="voteTool"><td class="vtEstimate">21</td><td><div><div class="vtMinus"><span class="glyphicon glyphicon-minus" aria-hidden="true"></span></div><div class="vtContent">0</div><div class="vtPlus"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span></div></div></td></tr>
										<tr class="voteTool"><td class="vtEstimate">50</td><td><div><div class="vtMinus"><span class="glyphicon glyphicon-minus" aria-hidden="true"></span></div><div class="vtContent">0</div><div class="vtPlus"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span></div></div></td></tr>
									</tbody>
								</table>
								<div style="margin-top: 15px">
									<ul id="voteResult" class="list-group">
										<li class="list-group-item"><div class="list-table-cell">recent stories with same estimate</div></li>
										<li class="list-group-item"><div class="list-table-cell">-</div></li>
									</ul>
								</div>
					</div>
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
			<div class="col-sm-3">
				<div class="input-group">
					<span class="input-group-addon"><span class="glyphicon glyphicon-tag" title="code" aria-hidden="true"></span></span>
					<input type="text" class="form-control" id="form-us-code">
				</div>
			</div>
			<div class="col-sm-3">
				<div class="input-group">
					<span class="input-group-addon"><span class="glyphicon glyphicon-usd" title="value" aria-hidden="true"></span></span>
					<input type="number" min="1" class="form-control" id="form-us-value">
				</div>
			</div>
			<div class="col-sm-3">
				<div class="input-group">
					<span class="input-group-addon"><span class="glyphicon glyphicon-cog" title="estimate" aria-hidden="true"></span></span>
					<select class="form-control" id="form-us-estimate">
						<option value="">-</option>
						<option value="0">0</option>
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="5">5</option>
						<option value="8">8</option>
						<option value="13">13</option>
						<option value="21">21</option>
						<option value="50">50</option>
					</select>
				</div>
			</div>
			<div class="col-sm-3">
				<div class="input-group">
					<span class="input-group-addon"><span class="glyphicon glyphicon-cog" title="status" aria-hidden="true"></span></span>
					<select class="form-control" id="form-us-status">
						<option value="">-</option>
						<option value="ready">ready</option>
						<option value="implementing">implementing</option>
						<option value="completed">completed</option>
					</select>
				</div>
			</div>
		</div>
		<div class="form-group">
			<label for="form-us-title" class="col-sm-2 control-label">title</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="form-us-title" required>
			</div>
		</div>
		<div class="form-group">
			<label for="form-us-description" class="col-sm-2 control-label">description</label>
			<div class="col-sm-10">
				<textarea id="form-us-description" class="form-control" rows="3"></textarea>
			</div>
		</div>
		<div class="form-group">
			<label for="form-us-criteria" class="col-sm-2 control-label">acceptance criteria</label>
			<div class="col-sm-10">
				<textarea id="form-us-criteria" class="form-control" rows="3"></textarea>
			</div>
		</div>
		<div class="form-group">
			<label for="form-us-test" class="col-sm-2 control-label">acceptance tests</label>
			<div class="col-sm-10">
				<textarea id="form-us-test" class="form-control" rows="3"></textarea>
			</div>
		</div>
		<div class="form-group hiddenInCreation">
			<label class="col-sm-2 control-label">dates</label>
			<div class="col-sm-10">
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

	<!-- Placed at the end of the document so the pages load faster -->
	<script src="${pageContext.request.contextPath}/resources/js/libs/jquery-1.11.0.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/libs/bootstrap.min.js"></script>

	<script src="${pageContext.request.contextPath}/resources/js/libs/bootstrap-table.min.js"></script>

	<script src="${pageContext.request.contextPath}/resources/js/about.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/common.js"></script>

	<script src="${pageContext.request.contextPath}/resources/js/userStory.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/backlogTable.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/estimateTool.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/backlog.js"></script>

	<script type="text/javascript">
		$(document).ready(function() {
			setAjaxPath('${pageContext.request.contextPath}');
			useLoader();
			initPage();
		});
	</script>

</body>
</html>