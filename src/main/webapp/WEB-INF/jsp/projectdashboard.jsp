<%@page session="false"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<tiles:insertDefinition name="dashboard">
	<tiles:putAttribute name="menu">
		<li><a href="<c:url value='/projects'/>/${projectId}/board"><span class="fa fa-table fa-2x"></span></a></li>
		<li><a href="<c:url value='/projects'/>/${projectId}"><span class="fa fa-gear fa-2x"></span></a></li>
	</tiles:putAttribute>

	<tiles:putAttribute name="body">

		<input id="projectId" type="hidden" value="${projectId}">

		<div class="titlebar">
			<div class="titlebar-item titlebar-primary titlebar-title">${title}</div>
		</div>

		<div class="col-md-3">
			<div class="dashboard">
				<div>
					<canvas id="myChart1" height="100" width="200"></canvas>
				</div>
				<h3>tasks by status</h3>
			</div>
			<div class="dashboard">
				<div>
					<canvas id="myChart2" height="100" width="200"></canvas>
				</div>
				<h3>tasks by category</h3>
			</div>
			<div class="dashboard">
				<div>
					<canvas id="myChart3" height="100" width="200"></canvas>
				</div>
				<h3>tasks by responsible</h3>
			</div>
		</div>
		<div class="col-md-9 dashboard">
			<div>
				<canvas id="myChart" height="450" width="800"></canvas>
			</div>
			<h3>cycle time</h3>
		</div>

	</tiles:putAttribute>
</tiles:insertDefinition>