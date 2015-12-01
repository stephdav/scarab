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

	<form class="form-horizontal">
		<div class="row">
			<div class="col-md-12">
				<div class="form-group">
					<label for="inputValue" class="col-md-1 control-label">name</label>
					<div class="col-md-5">
						<input type="text" class="form-control" id="inputValue" placeholder="project's name">
					</div>
					<label for="projectDescription" class="col-md-1 control-label">description</label>
					<div class="col-md-5">
						<textarea id="projectDescription" class="form-control" rows="3" placeholder="project's description"></textarea>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<div class="form-group">
					<label class="col-md-1 control-label">workflow</label>
					<div id="dnd" class="col-md-11">
						<div class="p"></div>
						<div class="p"></div>
						<div class="p"></div>
						<div class="p"></div>
					</div>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-md-12">
			        <div class="form-group form-group-options">
						<label class="col-md-1 control-label">categories</label>
						<div class="col-md-11">
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

		<div class="row">
			<div class="col-sm-12">
				<div class="form-group">
					<div class="col-sm-12">
				        <button type="button" class="cancelForm btn btn-default">cancel</button>
						<button type="button" class="submitForm btn btn-primary">create</button>
					</div>
				</div>
			</div>
		</div>
	</form>

	</tiles:putAttribute>
</tiles:insertDefinition>