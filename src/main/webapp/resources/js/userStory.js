/**
 * User storie utilities
 */

var ajaxPath;
function setAjaxPath(val) {
	ajaxPath = val;
}

function usCreate(us, callback) {
	$.ajax({
		url : ajaxPath + '/rest/us',
		type : 'POST',
		data :  usAjaxData(us),
		dataType : 'json',
		contentType : "application/json; charset=utf-8",
		success : callback
	});
}

function usUpdate(us, callback) {
	$.ajax({
		url: ajaxPath + '/rest/us',
		type: 'PUT',
		data: usAjaxData(us),
		dataType : 'json',
		contentType : "application/json; charset=utf-8",
		success: callback
	});
}

function usDelete(us, callback) {
	$.ajax({
		url: ajaxPath + '/rest/us/' + us.id,
		type: 'DELETE',
		dataType : 'json',
		contentType : "application/json; charset=utf-8",
		complete: callback
	});
}

function usAjaxData(us) {
	var data =  '{';
	if (typeof(us.id) != 'undefined') {
		data += '"id": "' + us.id + '", ';		
	}
	data += '"code": "' + us.code + '", '
		+ '"title": "' + us.title + '", '
		+ '"description": "' + us.desc + '", '
		+ '"accCrit": "' + us.crit + '", '
		+ '"accTest": "' + us.test + '"'
		+ '}';
	return data;
}

/** End of file */