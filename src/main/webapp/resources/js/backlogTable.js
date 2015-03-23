function codeTitleFormatter(value, row, index) {
	var content = "";
	if (typeof (value) != 'undefined' && value != '') {
		content = '<div class="codeAndTitle">[' + value + '] ' + row.title + '</div><div>' + row.description + '</div>';
	} else {
		content = '<div class="codeAndTitle">' + row.title + '</div><div>' + row.description + '</div>';
	}
	return content;
}

function statusFormatter(value, row, index) {
	var content = "";
	if (typeof (value) != 'undefined') {
		if (value == 'ready') {
			content = 'R';
		} else if (value == 'implementing') {
			content = 'I';
		} else if (value == 'completed') {
			content = 'D';
		} else {
			content = '-';
		}
	} else {
		content = '-';
	}
	return content;
}

function dateFormatter(value, row, index) {
	var content = "";
	if (typeof (value) != 'undefined' && value != '') {
		var d = new Date(value);
		content = d.toLocaleString();
	} else {
		content = '-';
	}
	return content;
}

function actionFormatter(value, row, index) {
	var content = '<div class="btn-group" data-us-id="' + row.id + '">'
			+ '<button type="button" class="btn btn-default btn-sm btn-us-edit" title="edit user story"><span class="glyphicon glyphicon-edit"></span></button>'
			+ '<button type="button" class="btn btn-default btn-sm btn-us-remove" title="delete user story"><span class="glyphicon glyphicon-trash"></span></button>'
			+ '</div>';
	return content;
}