<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="Sopra Group">
<title>scarab</title>
<link href="${pageContext.request.contextPath}/resources/images/favicon.png" rel="shortcut icon">
<link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/scarab.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/home.css" rel="stylesheet">
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
					<li><a href="${pageContext.request.contextPath}/backlog">product backlog</a></li>
					<li><a href="${pageContext.request.contextPath}/sprint">sprint planning</a></li>
					<li><a href="${pageContext.request.contextPath}/daily">daily scrum</a></li>
					<li><a href="${pageContext.request.contextPath}/review">sprint review</a></li>
					<li><a href="${pageContext.request.contextPath}/retro">sprint retrospective</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<div class="container-fluid">
    <div class="row">
        <div class="col-xs-12 col-sm-6 col-lg-4">
            <div class="box">
                <div class="icon">
                    <div class="image"><span class="glyphicon glyphicon-list-alt btn-lg white"></span></div>
                    <div class="info">
                        <h3 class="title">product backlog</h3>
                        <p id="usCount"></p>
                        <div class="more">
                            <a href="${pageContext.request.contextPath}/backlog" title="product backlog"><i class="glyphicon glyphicon-plus"></i> Details</a>
                        </div>
                    </div>
                </div>
                <div class="space"></div>
            </div>
        </div>
        <div class="col-xs-12 col-sm-6 col-lg-4">
            <div class="box">
                <div class="icon">
                    <div class="image"><span class="glyphicon glyphicon-map-marker btn-lg white"></span></div>
                    <div class="info">
                        <h3 class="title">sprint</h3>
                        <p>no active sprint</p>
                        <div class="more">
                            <a href="${pageContext.request.contextPath}/sprint" title="sprint"><i class="glyphicon glyphicon-plus"></i> Details</a>
                        </div>
                    </div>
                </div>
                <div class="space"></div>
            </div>
        </div>
        <div class="col-xs-12 col-sm-6 col-lg-4">
            <div class="box">
                <div class="icon">
                    <div class="image"><span class="glyphicon glyphicon-user btn-lg white"></span></div>
                    <div class="info">
                        <h3 class="title">team</h3>
                        <p id="teamCount"></p>
                        <div class="more">
                            <a href="#" title="team"><i class="glyphicon glyphicon-plus"></i> Details</a>
                        </div>
                    </div>
                </div>
                <div class="space"></div>
            </div>
        </div>
    </div>
    
    </div> <!-- /.container-fluid -->

	
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="${pageContext.request.contextPath}/resources/js/libs/jquery-1.11.0.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/libs/bootstrap.min.js"></script>

	<script src="${pageContext.request.contextPath}/resources/js/about.js"></script>

	<script type="text/javascript">

	$(document).ready(function() {
		initPage();
	});
	
	function initPage() {
	    $.getJSON('${pageContext.request.contextPath}/rest/summary', function(data) {
	    	$('#usCount').html('<strong>' + data.usCount + '</strong> user stories');
	    	$('#teamCount').html('<strong>' + data.teamCount + '</strong> members');
		});
	}

	</script>

</body>

</html>