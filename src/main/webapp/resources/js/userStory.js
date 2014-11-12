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
		data : '{' + '"code": "' + us.code + '",' + '"title": "' + us.title
				+ '", "description": "' + us.desc + '",' + '"accCrit": "'
				+ us.crit + '",' + '"accTest": "' + us.test + '"}',
		dataType : 'json',
		contentType : "application/json; charset=utf-8",
		success : callback
	});
}

function usUpdate(us, callback) {
	$.ajax({
		url: ajaxPath + '/rest/us',
		type: 'PUT',
		data: '{"id": "' + us.id + '", "code": "' + us.code + '", "title": "' + us.title + '", "description": "' + us.desc + '", "accCrit": "' + us.crit + '", "accTest": "' + us.test + '"}',
		dataType : 'json',
		contentType : "application/json; charset=utf-8",
		success: callback
	});
}