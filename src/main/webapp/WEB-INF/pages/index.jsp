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
<link href="${pageContext.request.contextPath}/resources/css/scarab.css" rel="stylesheet">
</head>

<body>

	<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
		<div class="container-fluid">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-links">
					<span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#">Scarab</a>
			</div>
			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse" id="navbar-links">
				<ul class="nav navbar-nav">
					<li class="active"><a href="#">Backlog</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<div class="container-fluid">

		<div style="padding-left:10px;">
			<div class="clearfix">
				<span class="list-group-title">User stories</span>
				<div class="pull-right"><button id="btn-us-create" type="button" class="btn btn-xs btn-default" title="create new user story"><span class="glyphicon glyphicon-plus"></span></button></div>
			</div>
			<ul id="list-allUS" class="list-group"></ul>
		</div>

		<div id="modal-us" class="modal fade">
			<div class="modal-dialog modal-lg" role="dialog" aria-labelledby="modal-us-title" aria-hidden="true">
				<div class="modal-content">
					<div class="modal-header">
						<h4 id="modal-us-title" class="modal-title">Create a user story</h4>
					</div>
					<div class="modal-body">
						<form id="form-us" class="form-horizontal" role="form">
							<span id="form-us-id" class="hidden"></span>
							<div class="form-group">
								<label for="form-us-code" class="col-sm-3 control-label">identifier</label>
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
								<div class="col-sm-offset-3 col-sm-9">
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

	</div>
	
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="${pageContext.request.contextPath}/resources/js/libs/jquery-1.11.0.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/libs/bootstrap.min.js"></script>

	<script type="text/javascript">

	var usAction = 'create';

	$(document).ready(function() {
		initPage();
	});

	function initPage() {
		displayUS();
		$("#btn-us-create").on("click", function() {
			usAction = 'create';
			$('#form-us button[type="submit"]').text('create');
			$('#modal-us').modal('show');
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

		$("#list-allUS").on("click", ".btn-us-edit", function() {
			var usId = $(this).closest("li").data("usId");
			editUSForm(usId);
		});
		$("#list-allUS").on("click", ".btn-us-remove", function() {
			var usId = $(this).closest("li").data("usId");
			var usTxt = $(this).closest("li").find(".list-group-item-heading").text();
			removeUS(usId, usTxt);
		});

		$('#modal-removeUS').on('hidden.bs.modal', function (e) {
			// remove event handlers
			$('#form-removeUS').off();
		});
	}
	
	function editUSForm(usId) {
		$('#form-us')[0].reset();
	    $.getJSON('${pageContext.request.contextPath}/rest/us/' + usId,	function(data) {
	    	if (typeof(data) != 'undefined') {
	    		$("#form-us-id").text(data.id);
	    		$("#form-us-code").val(data.code);
	    		$("#form-us-title").val(data.title);
	    		$("#form-us-description").text(data.description.replace(/<br>/g, '\n'));
	    		$("#form-us-criteria").text(data.accCrit.replace(/<br>/g, '\n'));
	    		$("#form-us-test").text(data.accTest.replace(/<br>/g, '\n'));
	    	}
			usAction = 'update';
			$('#form-us button[type="submit"]').text('update');
			$('#modal-us').modal('show');
		});
	}

	function removeUS(usId, usTxt) {
		$('#modal-removeUS .us-title').text(usTxt);
		$('#modal-removeUS').modal('show');
		$('#form-removeUS').on('submit', function(e) {
			e.preventDefault();
			$.ajax({
				url: '${pageContext.request.contextPath}/rest/us/' + usId,
				type: 'DELETE',
				dataType : 'json',
				contentType : "application/json; charset=utf-8",
				complete: function(html) {
					$('#modal-removeUS').modal('hide');
					displayUS();
				}
			});
        });
	}

	function createUS() {
		var usid = $("#form-us-code").val();
		var title = $("#form-us-title").val();
		var desc = $("#form-us-description").val().replace(/(\r\n|\n\r|\r|\n)/g, '<br>');     
		var crit = $("#form-us-criteria").val().replace(/(\r\n|\n\r|\r|\n)/g, '<br>');     
		var test = $("#form-us-test").val().replace(/(\r\n|\n\r|\r|\n)/g, '<br>');     
		$.ajax({
			url: '${pageContext.request.contextPath}/rest/us',
			type: 'POST',
			data: '{"code": "' + usid + '", "title": "' + title + '", "description": "' + desc + '", "accCrit": "' + crit + '", "accTest": "' + test + '"}',
			dataType : 'json',
			contentType : "application/json; charset=utf-8",
			success: function(html) {
				$('#modal-us').modal('hide');
				$('#form-us')[0].reset();
				displayUS();
			}
		});
	}
	
	function editUS() {
		var _id = $("#form-us-id").text();
		var usid = $("#form-us-code").val();
		var title = $("#form-us-title").val();
		var desc = $("#form-us-description").val().replace(/(\r\n|\n\r|\r|\n)/g, '<br>');     
		var crit = $("#form-us-criteria").val().replace(/(\r\n|\n\r|\r|\n)/g, '<br>');     
		var test = $("#form-us-test").val().replace(/(\r\n|\n\r|\r|\n)/g, '<br>');     
		$.ajax({
			url: '${pageContext.request.contextPath}/rest/us',
			type: 'PUT',
			data: '{"id": "' + _id + '", "code": "' + usid + '", "title": "' + title + '", "description": "' + desc + '", "accCrit": "' + crit + '", "accTest": "' + test + '"}',
			dataType : 'json',
			contentType : "application/json; charset=utf-8",
			success: function(html) {
				$('#modal-us').modal('hide');
				$('#form-us')[0].reset();
				displayUS();
			}
		});
	}
	
	function displayUS() {
	    $.getJSON('${pageContext.request.contextPath}/rest/us',	function(data) {
			$("#list-allUS").empty();
		   	if (data.length > 0) {

		   		var elt = '<li class="list-group-item"><div class="row">'
    			+ '<div class="col-sm-3 list-table-cell">[code] title &amp; description</div>'
    		 	+ '<div class="col-sm-4 list-table-cell">acceptance criteria</div>'
    		 	+ '<div class="col-sm-4 list-table-cell">acceptance tests</div>'
    		 	+ '<div class="col-sm-1 text-right">action</div>'
    		 	+ '</div></li>';

		   		$.each(data, function(i, us) {
		   			elt += '<li class="list-group-item" data-us-id="' + us.id + '"><div class="row">'
		   				+ '<div class="col-sm-3 list-table-cell">'
		   				+   '<div class="list-group-item-heading">';
		   			 if (typeof(us.code) != 'undefined' && us.code != '') {
		    			 elt += '[' + us.code + '] ';
		   			 }
		   			 elt += us.title 
		   			 	+   '</div>'
		   			 	+   '<div class="list-group-item-text">' + us.description + '</div>'
		   			 	+ '</div>'
		   			 	+ '<div class="col-sm-4 list-table-cell">' + us.accCrit + '</div>'
		   			 	+ '<div class="col-sm-4 list-table-cell">' + us.accTest + '</div>'
		   				+ '<div class="col-sm-1 clearfix">'
		   				+   '<div class="btn-group pull-right">'
		   				+     '<button type="button" class="btn btn-default btn-sm btn-us-edit" title="edit user story"><span class="glyphicon glyphicon-edit"></span></button>'
		   				+     '<button type="button" class="btn btn-default btn-sm btn-us-remove" title="delete user story"><span class="glyphicon glyphicon-trash"></span></button>'
		   				+   '</div>'
		   				+ '</div>'
		   			 	+ '</div></li>';

		   		});
		   		
	    		$("#list-allUS").append(elt);
		   	}
		});
	}

	</script>

</body>
</html>