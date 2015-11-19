<%@page session="true"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<tiles:insertDefinition name="admin">
	<tiles:putAttribute name="menu">
		<li><a id="btnCreateUser"><span class="fa fa-user-plus fa-2x"></span></a></li>
	</tiles:putAttribute>

	<tiles:putAttribute name="body">

		<div class="titlebar">
			<div class="titlebar-item titlebar-primary">
				<div class="titlebar-title">${title}</div>
			</div>
		</div>

		<div class="row">
			<div class="col-md-6 clearfix">
				<div class="panel panel-default">
					<div class="panel-heading">users</div>
					<ul id="users" class="list-group"></ul>
				</div>
			</div>
		</div>

<div class="modal fade" id="dialogCreateUser" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="dialogCreateUserLabel">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="dialogCreateUserLabel">new user</h4>
      </div>
      <div class="modal-body">
		<form class="form-horizontal">
			<div class="form-group">
				<label for="userName" class="col-sm-3 control-label">username</label>
				<div class="col-sm-9">
					<input type="text" class="form-control" id="userName" placeholder="user's name">
				</div>
			</div>
			<div class="form-group">
				<label for="userPassword" class="col-sm-3 control-label">password</label>
				<div class="col-sm-9">
					<input type="password" class="form-control" id="userPassword">
				</div>
			</div>
			<div class="form-group">
				<label for="userPassword" class="col-sm-3 control-label">admin ?</label>
				<div class="col-sm-9">
					<div class="checkbox">
						<label>
							<input type="checkbox" id="userAdmin" value="">
						</label>
					</div>
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