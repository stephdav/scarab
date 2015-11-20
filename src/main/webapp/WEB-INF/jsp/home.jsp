<%@page session="false"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<tiles:insertDefinition name="home">

	<tiles:putAttribute name="menu">
		<sec:authorize access="hasRole('ROLE_ADMIN')" var="isAdmin" />
		<li><a href="<c:url value='/projectNew'/>"><span class="fa fa-plus fa-2x" title="new project"></span></a></li>
		<c:if test="${isAdmin}">
			<li><a href="<c:url value='/admin'/>"><span class="fa fa-users fa-2x" title="admin"></span></a></li>
		</c:if>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="body">

		<div class="titlebar">
			<div class="titlebar-item titlebar-primary">
				<div class="titlebar-title">welcome ${pageContext.request.userPrincipal.name} !</div>
			</div>
 		</div>
		<div class="row">
			<div class="col-md-6 clearfix">
				<div class="panel panel-default">
					<div class="panel-heading">projects</div>
					<ul id="projects" class="list-group"></ul>
				</div>
			</div>
		</div>

	</tiles:putAttribute>
</tiles:insertDefinition>