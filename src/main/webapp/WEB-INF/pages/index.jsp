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
				<div class="pull-right"><button type="button" class="btn btn-xs btn-default" data-toggle="modal" data-target="#modal-createUS" title="create new user story"><span class="glyphicon glyphicon-plus"></span></button></div>
			</div>
			<ul id="list-allUS" class="list-group"></ul>
		</div>

		<div id="modal-createUS" class="modal fade">
			<div class="modal-dialog modal-lg" role="dialog" aria-labelledby="modal-createUS-title" aria-hidden="true">
				<div class="modal-content">
					<div class="modal-header">
						<h4 id="modal-createUS-title" class="modal-title">Create a user story</h4>
					</div>
					<div class="modal-body">
						<form id="form-createUS" class="form-horizontal" role="form">
							<div class="form-group">
								<label for="form-createUS-identifier" class="col-sm-3 control-label">identifier</label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="form-createUS-identifier">
								</div>
							</div>
							<div class="form-group">
								<label for="form-createUS-title" class="col-sm-3 control-label">title</label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="form-createUS-title" required>
								</div>
							</div>
							<div class="form-group">
								<label for="form-createUS-description" class="col-sm-3 control-label">description</label>
								<div class="col-sm-9">
									<textarea id="form-createUS-description" class="form-control" rows="3"></textarea>
								</div>
							</div>
							<div class="form-group">
								<label for="form-createUS-criteria" class="col-sm-3 control-label">acceptance criteria</label>
								<div class="col-sm-9">
									<textarea id="form-createUS-criteria" class="form-control" rows="3"></textarea>
								</div>
							</div>
							<div class="form-group">
								<label for="form-createUS-test" class="col-sm-3 control-label">acceptance tests</label>
								<div class="col-sm-9">
									<textarea id="form-createUS-test" class="form-control" rows="3"></textarea>
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-offset-3 col-sm-9">
									<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
									<button type="submit" class="btn btn-primary">Create</button>
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

	$(document).ready(function() {
		initPage();
	});

	function initPage() {
		displayUS();
		$('#form-createUS').on('submit', function(e) {
			e.preventDefault();
			createUS();
        });
		$("#list-allUS").on("click", ".btn-us-edit", function() {
			var usId = $(this).closest("li").data("usId");
			editUS(usId);
		});
		$("#list-allUS").on("click", ".btn-us-remove", function() {
			var usId = $(this).closest("li").data("usId");
			editUS(usId);
		});

	}
	
	function editUS(usId) {
		alert("Edit US " + usId);		
	}

	function removeUS(usId) {
		alert("Remove US " + usId);		
	}

	function createUS() {
		var usid = $("#form-createUS-identifier").val();
		var title = $("#form-createUS-title").val();
		var desc = $("#form-createUS-description").val().replace(/(\r\n|\n\r|\r|\n)/g, '<br>');     
		var crit = $("#form-createUS-criteria").val().replace(/(\r\n|\n\r|\r|\n)/g, '<br>');     
		var test = $("#form-createUS-test").val().replace(/(\r\n|\n\r|\r|\n)/g, '<br>');     
		$.ajax({
			url: '${pageContext.request.contextPath}/rest/us',
			type: 'POST',
			data: '{"code": "' + usid + '", "title": "' + title + '", "description": "' + desc + '", "accCrit": "' + crit + '", "accTest": "' + test + '"}',
			dataType : 'json',
			contentType : "application/json; charset=utf-8",
			success: function(html) {
				$('#form-createUS-title').val("");
				$('#form-createUS-description').val("");
				$('#modal-createUS').modal('hide');
				$('#form-createUS')[0].reset();
				displayUS();
			}
		});
	}
	
	function displayUS() {
	    $.getJSON('${pageContext.request.contextPath}/rest/us',
			function(data) {
				$("#list-allUS").empty();
		    	if (data.length > 0) {
		    		var elt = '<li class="list-group-item"><div class="row">'
    				+ '<div class="col-sm-3 list-table-cell">[code] title &amp; description</div>'
    			 	+ '<div class="col-sm-4 list-table-cell">acceptance criteria</div>'
    			 	+ '<div class="col-sm-4 list-table-cell">acceptance tests</div>'
    			 	+ '<div class="col-sm-1 list-table-cell">action</div>'
    			 	+ '</div></li>';

		    		$.each(data, function(i, us) {
		    			elt += '<li class="list-group-item" data-us-id="' + us.id + '"><div class="row">'
		    				+ '<div class="col-sm-3 list-table-cell">'
		    				+   '<div class="list-group-item-heading">';
		    			 if (typeof(us.code) != 'undefined' && us.code != '') {
			    			 elt += '[' + us.code + '] ';
		    			 }
		    			 elt += us.title 
		    			 	+ '  </div>'
		    			 	+ '  <div class="list-group-item-text">' + us.description + '</div>'
		    			 	+ '</div>'
		    			 	+ '<div class="col-sm-4 list-table-cell">' + us.accCrit + '</div>'
		    			 	+ '<div class="col-sm-4 list-table-cell">' + us.accTest + '</div>'
		    				+ '<div class="col-sm-1 clearfix">'
		    				+ '  <div class="btn-group pull-right">'
		    				+ '    <button type="button" class="btn btn-default btn-sm btn-us-edit" title="edit user story"><span class="glyphicon glyphicon-edit"></span></button>'
		    				+ '    <button type="button" class="btn btn-default btn-sm btn-us-remove" title="delete user story"><span class="glyphicon glyphicon-trash"></span></button>'
		    				+ '  </div>'
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