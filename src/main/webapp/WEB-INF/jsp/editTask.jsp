<%@page session="true"%>
<%@taglib prefix="c"     uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@taglib prefix="form"  uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn"   uri="http://java.sun.com/jsp/jstl/functions" %>

<tiles:insertDefinition name="editTask">
	<tiles:putAttribute name="menu">
		<span></span>
	</tiles:putAttribute>

	<tiles:putAttribute name="body">

	<div class="titlebar">
		<div class="titlebar-item titlebar-primary titlebar-title">edit task #${task.id}</div>
	</div>

	<input id="projectId" type="hidden" value="${projectId}">
	<input id="taskId" type="hidden" value="${task.id}">

	<form class="form-horizontal">
		<div class="col-sm-6">
			<div class="form-group">
				<label for="taskTitle" class="col-sm-3 control-label">title</label>
				<div class="col-sm-9">
					<input type="text" class="form-control" id="taskTitle" placeholder="task's title" value="${task.title}">
				</div>
			</div>
			<div class="form-group">
				<label for="taskDescription" class="col-sm-3 control-label">description</label>
				<div class="col-sm-9">
					<textarea id="taskDescription" class="form-control" rows="3" placeholder="task's description">${task.description}</textarea>
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-3 col-sm-9">
					<button type="button" class="cancelForm btn btn-default">cancel</button>
					<button type="button" class="submitForm btn btn-primary">update</button>
				</div>
			</div>
		</div>
		<div class="col-sm-6">
			<div class="form-group">
				<label for="taskStatus" class="col-sm-3 control-label">status</label>
				<div class="col-sm-9">
					<select id="taskStatus" class="form-control" >
						<c:forEach var="sta" items="${projectColumns}">
							<c:choose>
								<c:when test="${task.status.id == sta.id}"><option value="${sta.id}" selected>${sta.name}</option></c:when>
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
							<c:choose>
								<c:when test="${task.category == null}"><option value="" selected>-- none --</option></c:when>
								<c:otherwise><option value="">-- none --</option></c:otherwise>
							</c:choose>	
							<c:forEach var="cat" items="${projectCategories}">
								<c:choose>
									<c:when test="${task.category.id == cat.id}"><option value="${cat.id}" selected>${cat.name}</option></c:when>
									<c:otherwise><option value="${cat.id}">${cat.name}</option></c:otherwise>
								</c:choose>	
							</c:forEach>
						</select>
					</div>
				</div>
			</c:if>
			<div class="form-group">
				<label for="taskAssigned" class="col-sm-3 control-label">assigned to</label>
				<div class="col-sm-9">
					<select id="taskAssigned" class="form-control">
						<c:choose>
							<c:when test="${task.user == null}"><option value="" selected>-- nobody --</option></c:when>
							<c:otherwise><option value="">-- nobody --</option></c:otherwise>
						</c:choose>
						<c:forEach var="usr" items="${users}">
							<c:choose>
								<c:when test="${task.user.id == usr.id}"><option value="${usr.id}" selected>${usr.username}</option></c:when>
								<c:otherwise><option value="${usr.id}">${usr.username}</option></c:otherwise>
							</c:choose>	
						</c:forEach>
					</select>
				</div>
			</div>
		</div>
	</form>

	</tiles:putAttribute>
</tiles:insertDefinition>