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

	<div class="container">

		<h1>Scarab</h1>

		<div  class="col-md-7" style="border-left:3px solid black; padding-left:10px;">
			<h2>User stories</h2>
			<ul id="list-allUS" class="list-group"></ul>
			<div class="table-responsive">
				<table id="table-allUS" class="table">
				<thead>
					<tr><td>col1</td><td>col2</td></tr>
				</thead>
				</table>
			</div>
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
				$("#table-allUS").empty();
		    	if (data.length > 0) {
		    		var elt, elt2;
		    		$.each(data, function(i, us) {
		    			elt += '<li class="list-group-item">'
		    			  + '<h4 class="list-group-item-heading">' + us.title + '</h4>'
		    			  + '<p class="list-group-item-text">' + us.description + '</p>'
		    			  + '</li>';

		    			elt2 += '<tr><td>' + us.title + '</td><td>' + us.description + '</td></tr>';
		    		});
	    			//$("#list-allUS").append(elt);
		    		$("#table-allUS").append(elt2);
		    	}
			});
	}

	</script>

</body>
</html>