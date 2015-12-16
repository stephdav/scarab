<%@page session="true"%>
<%@taglib prefix="c"     uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@taglib prefix="form"  uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn"   uri="http://java.sun.com/jsp/jstl/functions" %>

<tiles:insertDefinition name="tasks">
	<tiles:putAttribute name="menu">
		<li><a id="btnCreateTask"><span class="fa fa-plus fa-2x" title="new task"></span></a></li>
		<li><a href="<c:url value='/projects'/>/${projectId}/dashboard"><span class="fa fa-dashboard fa-2x" title="analytics"></span></a></li>
		<li><a href="<c:url value='/projects'/>/${projectId}"><span class="fa fa-gear fa-2x" title="project's options"></span></a></li>
	</tiles:putAttribute>

	<tiles:putAttribute name="body">

		<div class="titlebar">
			<div class="titlebar-item titlebar-primary">
				<div class="titlebar-title">${title}</div>
			</div>
		</div>

		<input id="projectId" type="hidden" value="${projectId}">
		<input id="nbColumns" type="hidden" value="${fn:length(projectColumns)}">
		
		<div id="board" class="row">

			<div class="board-header clearfix">
				<c:forEach var="col" items="${projectColumns}">
					<div class="board-column">
						<div class="column-header">${col.name}</div>
					</div>
				</c:forEach>
			</div>

			<c:forEach var="row" items="${projectCategories}">
				<div class="board-content clearfix">
					<c:forEach var="col" items="${projectColumns}">
						<div class="board-column">
							<div class="column" data-category="${row.id}" data-status="${col.id}"></div>
						</div>
					</c:forEach>
				</div>
			</c:forEach>

			<div class="board-content clearfix">
				<c:forEach var="col" items="${projectColumns}">
					<div class="board-column">
						<div class="column" data-category="" data-status="${col.id}"></div>
					</div>
				</c:forEach>
			</div>
		</div>

<div class="modal fade" id="dialogCreateTask" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="dialogCreateTaskLabel">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="dialogCreateTaskLabel">new task</h4>
      </div>
      <div class="modal-body">
		<form class="form-horizontal">
			<div class="form-group">
				<label for="taskTitle" class="col-sm-3 control-label">title</label>
				<div class="col-sm-9">
					<input type="text" class="form-control" id="taskTitle" placeholder="task's title">
				</div>
			</div>
			<div class="form-group">
				<label for="taskDescription" class="col-sm-3 control-label">description</label>
				<div class="col-sm-9">
					<textarea id="taskDescription" class="form-control" rows="3" placeholder="task's description"></textarea>
				</div>
			</div>
			<div class="form-group">
				<label for="taskStatus" class="col-sm-3 control-label">status</label>
				<div class="col-sm-9">
					<select id="taskStatus" class="form-control">
						<c:forEach var="sta" items="${projectColumns}" varStatus="idx">
 							<c:choose>
								<c:when test="${idx.index==0}"><option value="${sta.id}" selected>${sta.name}</option></c:when>
								<c:otherwise><option value="${sta.id}">${sta.name}</option></c:otherwise>
							</c:choose>	
						</c:forEach>
					</select>
				</div>
			</div>
			<c:if test="${fn:length(projectCategories) > 0}">
				<div class="form-group">
					<label for="taskCategory" class="col-sm-3 control-label">category</label>
					<div class="col-sm-9">
						<select id="taskCategory" class="form-control">
							<option value="" selected>-- none --</option>
							<c:forEach var="cat" items="${projectCategories}">
								<option value="${cat.id}">${cat.name}</option>
							</c:forEach>
						</select>
					</div>
				</div>
			</c:if>
			<div class="form-group">
				<label for="taskAssigned" class="col-sm-3 control-label">assigned to</label>
				<div class="col-sm-9">
					<select id="taskAssigned" class="form-control">
						<option value="" selected>-- nobody --</option>
						<c:forEach var="usr" items="${users}">
							<option value="${usr.id}">${usr.username}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">cancel</button>
		<button type="button" class="submitForm btn btn-primary">create</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

	</tiles:putAttribute>
</tiles:insertDefinition>