$(document).ready(function() {
	$('#btnCreateUser').on('click', function(e) {
		$('#userName').val("");
		$('#userPassword').val("");
		$('#userAdmin').attr('checked', false);;
		$('#dialogCreateUser').modal('show');
	});
	$('#dialogCreateUser').on('shown.bs.modal', function () {
		$('#userName').focus();
	})
	$('#dialogCreateUser .submitForm').on('click', function(e) {
		createUser($("#userName").val(), $("#userPassword").val(), $("#userAdmin").is(':checked'));
	});
	$('#users').on('click','.deleteUser', function(e) {
		e.stopPropagation();
		var userId = $(this).closest('li').attr('data-usr');
		deleteUser(userId);
	});
	updateUsersList();
});

function updateUsersList() {
	$.ajax({
		url : "api/users"
	}).then(function(data) {
		$('#users').empty();
		$.each(data, function(index, value) {
			var elt = '<li class="list-group-item" data-usr="' + value.id + '">' + value.username;
			if (value.role == "ROLE_ADMIN") {
				elt += ' <span class="fa fa-star"></span>';				
			}
			elt += '<button type="button" class="deleteUser btn btn-sm btn-default pull-right"><span class="fa fa-close" aria-hidden="true"></span></button>';
			elt += '</li>';
			$('#users').append(elt);
		});
	});
}

function createUser(username, password, isAdmin) {
	apiUserCreate(
		username, password, isAdmin,
		function(data) {
			$('#dialogCreateUser').modal('hide');
			showAlertSuccess("User created.");
			updateUsersList();
		},
		function(jqXHR, textStatus, errorThrown) {
			$('#dialogCreateUser').modal('hide');
			var errorMessage = "Failed to create user.";
			if (jqXHR.status == 409) {
				errorMessage += "<br>Username already exists.";				
			}
			showAlertError(errorMessage);
			updateUsersList();
		});
}

function deleteUser(id) {
	apiUserDelete(
		id,
		function(data) {
			showAlertSuccess('User deleted.')
			updateUsersList();
		},
		function(textStatus, errorThrown) {
			showAlertError('Failed to delete user.')
			updateUsersList();
		});
}