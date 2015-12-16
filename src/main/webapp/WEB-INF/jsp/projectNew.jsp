<%@page session="true"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<tiles:insertDefinition name="projectNew">
	<tiles:putAttribute name="menu">
		<span></span>
	</tiles:putAttribute>

	<tiles:putAttribute name="body">

	<div class="titlebar">
		<div class="titlebar-item titlebar-primary titlebar-title">new project</div>
	</div>

<form id="newProjectForm">
	<div class="row">
		<div class="col-md-6">
			<div class="panel panel-default">
				<div class="panel-heading">description</div>
				<div class="panel-body form-horizontal">
					<div class="form-group">
						<label for="projectName" class="col-md-2 control-label">name</label>
						<div class="col-md-10">
							<input type="text" id="projectName" name="projectName" class="form-control" placeholder="project's name">
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
							<div class="input-group input-group-option">
								<input type="text" name="category[]" class="form-control" placeholder="enter a new category name">
								<span class="input-group-btn input-group-addon-remove">
									<button class="btn btn-default" type="button"><span class="fa fa-close"></span></button>
								</span>
							</div>
							<div class="input-group input-group-option">
								<input type="text" name="category[]" class="form-control" placeholder="enter a new category name">
								<span class="input-group-btn input-group-addon-remove">
									<button class="btn btn-default" type="button"><span class="fa fa-close"></span></button>
								</span>
							</div>
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
						<div class="statusLabel"></div>
						<div class="statusLabel"></div>
						<div class="statusLabel"></div>
						<div class="statusLabel"></div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="row">
		<div class="col-md-12">
			<div class="form-group">
				<div class="col-md-offset-1 col-md-11">
			        <button type="button" class="cancelForm btn btn-default">cancel</button>
					<button type="button" class="submitForm btn btn-primary">create</button>
				</div>
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