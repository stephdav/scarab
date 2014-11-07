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

		<div style="border-left:3px solid black; padding-left:10px;">
			<h2>Create a user story</h2>
			<form class="form-horizontal" role="form">
				<div class="form-group">
					<label for="form-createUS-title" class="col-sm-2 control-label">title</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="form-createUS-title">
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

</body>
</html>