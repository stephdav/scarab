<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<tiles:importAttribute name="stylesheets"/>
<tiles:importAttribute name="javascripts"/>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="">
	<meta name="author" content="Sopra Group">
	<meta name="_csrf" content="${_csrf.token}"/>
	<meta name="_csrf_header" content="${_csrf.headerName}"/>

	<title>${title}</title>
	<link href="${pageContext.request.contextPath}/resources/images/favicon.png" rel="shortcut icon">

    <!-- stylesheets -->
    <c:forEach var="css" items="${stylesheets}">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/<c:url value="${css}"/>">
    </c:forEach>
    <!-- end stylesheets -->
</head>

<body>

<div>

	<div class="side-menu">

		<nav class="navbar navbar-default" role="navigation">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<div class="brand-wrapper">
					<!-- Hamburger -->
					<button type="button" class="navbar-toggle"><span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button>
					<!-- Brand -->
					<div class="brand-name-wrapper">
						<a class="navbar-brand" href="${pageContext.request.contextPath}">
						<img alt="Brand" src="${pageContext.request.contextPath}/resources/images/scarab.png" class="img-responsive">
						</a>
					</div>
				</div>
			</div>
	
			<!-- Main Menu -->
			<div class="side-menu-container">
				<ul class="nav navbar-nav">
					<c:if test="${pageContext.request.userPrincipal.name != null}">
						<tiles:insertAttribute name="menu" />
		          		<li><form action="<c:url value="/j_spring_security_logout" />" name="signOut" class="navbar-nav" method="post">
		          			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		 					<!-- <input type="submit" class="btn btn-default" value="logout" /> -->
							<a onclick="document.signOut.submit()"><span class="fa fa-sign-out fa-2x"></span></a>
						</form></li>
		          	</c:if>
				</ul>
			</div>
		</nav>
	
	</div>

	<!-- Main Content -->
	<div class="container-fluid">
		<div class="side-body">
			<tiles:insertAttribute name="body" />
		</div>
	</div>

</div>

	<!-- scripts -->
	<c:forEach var="script" items="${javascripts}">
		<script src="${pageContext.request.contextPath}/<c:url value="${script}"/>"></script>
	</c:forEach>
	<script type="text/javascript" >
		var contextPath = "<%=request.getContextPath()%>"; 
	</script>
	<!-- end scripts -->

</body>
</html>