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
<link href="${pageContext.request.contextPath}/resources/css/sprint.css" rel="stylesheet">
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
					<li><a href="${pageContext.request.contextPath}/backlog">product backlog</a></li>
					<li class="active"><a href="${pageContext.request.contextPath}/sprint">sprint planning</a></li>
					<li><a href="${pageContext.request.contextPath}/daily">daily scrum</a></li>
					<li><a href="${pageContext.request.contextPath}/review">sprint review</a></li>
					<li><a href="${pageContext.request.contextPath}/retro">sprint retrospective</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<div class="container-fluid">
		<h1>sprint planning</h1>

			<div id="custom-toolbar">
				<button id="btn-us-create" type="button"
					class="btn btn-sm btn-default" title="create new user story">
					<span class="glyphicon glyphicon-plus"></span>
				</button>
				<span class="list-group-title">product backlog <a
					class="scrum-info" data-toggle="modal"
					data-target="#aboutProductBacklog"><span
						class="glyphicon glyphicon-info-sign"></span></a></span>
			</div>
			<table id="myTable" class="table table-hover table-condensed"
				data-toggle="table" data-url="rest/us" data-cache="false"
				data-toolbar="#custom-toolbar" data-sort-name="code"
				data-sort-order="asc" data-search="true" data-show-refresh="true"
				data-show-columns="true">
				<thead>
					<tr>
						<th data-field="code" class="col-md-3"
							data-formatter="codeTitleFormatter" data-sortable="true">[code]
							title &amp; description</th>
						<th data-field="accCrit" class="col-md-3">acceptance criteria</th>
						<th data-field="accTest" class="col-md-3">acceptance tests</th>
						<th data-field="creationDate" class="col-md-1"
							data-formatter="dateFormatter" data-visible="false"
							data-sortable="true" data-halign="center" data-align="center">creation
							date</th>
						<th data-field="modificationDate" class="col-md-1"
							data-formatter="dateFormatter" data-sortable="true"
							data-halign="center" data-align="center">modification date</th>
						<th data-formatter="actionFormatter" class="col-md-1"
							data-halign="center" data-align="center">action</th>
					</tr>
				</thead>
			</table>
	</div> <!-- /.container-fluid -->

	
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="${pageContext.request.contextPath}/resources/js/libs/jquery-1.11.0.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/libs/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/libs/bootstrap-table.min.js"></script>

	<script src="${pageContext.request.contextPath}/resources/js/about.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/backlogTable.js"></script>

	<script type="text/javascript">

	$(document).ready(function() {
	});

	</script>

</body>

</html>