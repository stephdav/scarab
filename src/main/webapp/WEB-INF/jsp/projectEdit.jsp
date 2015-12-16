<%@page session="true"%>
<%@taglib prefix="c"     uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@taglib prefix="form"  uri="http://www.springframework.org/tags/form"%>

<tiles:insertDefinition name="projectEdit">
	<tiles:putAttribute name="menu">
		<li><a href="<c:url value='/projects'/>/${projectId}/board"><span class="fa fa-table fa-2x" title="back to board"></span></a></li>
	</tiles:putAttribute>

	<tiles:putAttribute name="body">

	<div class="titlebar">
		<div class="titlebar-item titlebar-primary titlebar-title">edit project #${project.id}</div>
	</div>

	<input id="projectId" type="hidden" value="${projectId}">
	<input id="projectDesc" type="hidden" value="${project.description}">

<form id="editProjectForm">
	<div class="row">
		<div class="col-md-6">
			<div class="panel panel-default">
				<div class="panel-heading">description</div>
				<div class="panel-body form-horizontal">
					<div class="form-group">
						<label for="projectName" class="col-md-2 control-label">name</label>
						<div class="col-md-10">
							<input type="text" id="projectName" name="projectName" value="${project.name}" class="form-control" placeholder="project's name">
						</div>
					</div>
					<div class="form-group">
						<label for="projectDescription" class="col-md-2 control-label">description</label>
						<div class="col-md-10">
							<textarea id="projectDescription" name="projectDescription" class="form-control" rows="3" placeholder="project's description"></textarea>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="col-md-6">
			<div class="panel panel-default" style="min-height:216px">
				<div class="panel-heading">task properties</div>
				<div class="panel-body form-horizontal">
					<div class="form-group form-group-options">
						<label class="col-md-2 control-label">categories</label>
						<div class="col-md-10">
							<c:forEach var="cat" items="${project.categories}">
					    		<div class="input-group input-group-option">
					    			<input type="text" name="category[]" class="form-control" value="${cat.name}" data-cat="${cat.id}" placeholder="enter a new category name">
					    			<span class="input-group-btn input-group-addon-remove">
										<button class="btn btn-default" type="button"><span class="fa fa-close"></span></button>
									</span>
					    		</div>
							</c:forEach>
				    		<div class="input-group input-group-option">
				    			<input type="text" name="category[]" class="form-control" placeholder="enter a new category name">
				    			<span class="input-group-btn input-group-addon-remove">
									<button class="btn btn-default" type="button"><span class="fa fa-close"></span></button>
								</span>
				    		</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<div class="panel panel-default">
				<div class="panel-heading">workflow</div>
				<div class="panel-body">
					<div id="dnd">
						<c:forEach var="col" items="${project.columns}">
							<div class="statusLabel" data-col="${col.id}">${col.name}</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="row">
		<div class="col-md-12">
			<div class="form-group">
		        <button type="button" class="cancelForm btn btn-default">cancel</button>
				<button type="button" class="submitForm btn btn-primary">update</button>
			</div>
		</div>
	</div>
</form>

<div id="editColumnModal" class="modal fade" tabindex="-1" role="dialog" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header"><h4 class="modal-title">update status label</h4></div>
			<div class="modal-body">
				<form class="form-horizontal">
					<div class="form-group">
						<label for="inputWkfLbl" class="col-sm-3 control-label">workflow step</label>
						<div class="col-sm-9">
							<input type="text" class="form-control" id="inputWkfLbl">
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">cancel</button>
				<button type="button" class="btn btn-primary btnUpdate">update</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->

	</tiles:putAttribute>
</tiles:insertDefinition>