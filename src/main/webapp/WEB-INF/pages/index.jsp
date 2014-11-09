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
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#navbar-links">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
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

		<div  class="col-md-7" style="border-left:3px solid black; padding-left:10px;">
			<h2>User stories</h2>
			<div class="row" style="padding-left:10px;">
				<div class="col-sm-4">title</div>
		    	<div class="col-sm-8">description</div>
		    </div>
			<ul id="list-allUS" class="list-group"></ul>
		</div>
		
		<div class="col-md-5" style="border-left:3px solid black; padding-left:10px;">
			<h2>Create a user story</h2>
			<form id="form-createUS" class="form-horizontal" role="form">
				<div class="form-group">
					<label for="form-createUS-title" class="col-sm-2 control-label">title</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="form-createUS-title" required>
					</div>
				</div>
				<div class="form-group">
					<label for="form-createUS-description" class="col-sm-2 control-label">description</label>
					<div class="col-sm-10">
						<textarea id="form-createUS-description" class="form-control" rows="3"></textarea>
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
						<button type="submit" class="btn btn-default">Create</button>
					</div>
				</div>
			</form>
		</div>

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
	}
	
	function createUS() {
		var title = $("#form-createUS-title").val();
		var desc = $("#form-createUS-description").val().replace(/(\r\n|\n\r|\r|\n)/g, '<br>');     
		$.ajax({
			url: '${pageContext.request.contextPath}/rest/us',
			type: 'POST',
			data: '{"title": "' + title + '", "description": "' + desc + '"}',
			dataType : 'json',
			contentType : "application/json; charset=utf-8",
			success: function(html) {
				$('#form-createUS-title').val("");
				$('#form-createUS-description').val("");
			}
		});
	}
	
	function displayUS() {
	    $.getJSON('${pageContext.request.contextPath}/rest/us',
			function(data) {
				$("#list-allUS").empty();
		    	if (data.length > 0) {
		    		var elt = "";
		    		$.each(data, function(i, us) {
		    			elt += '<li class="list-group-item"><div class="row">'
		    			  + '<div class="col-sm-4">' + us.title + '</div>'
		    			  + '<div class="col-sm-8">' + us.description + '</div>'
		    			  + '</div></li>';
		    		});
		    		
	    			$("#list-allUS").append(elt);
		    	}
			});
	}

	</script>

</body>
</html>