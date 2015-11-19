$(function() {
	$('.navbar-toggle').click(function() {
		$('.navbar-nav').toggleClass('slide-in');
		$('.side-body').toggleClass('body-slide-in');
	});
});

function goTo(path) {
	window.location.href = contextPath +"/" + path;
}

function showAlertError(msg) {
	$.notify({
		icon : 'fa fa-warning',
		message : msg
	}, {
		type : 'danger',
		placement : {
			from : "bottom",
			align : "right"
		},
		allow_dismiss : false,
		delay : 3000
	});
}

function showAlertSuccess(msg) {
	$.notify({
		icon : 'fa fa-info-circle',
		message : msg
	}, {
		type : 'success',
		placement : {
			from : "bottom",
			align : "right"
		},
		allow_dismiss : false,
		delay : 3000
	});
}

function replaceAll(string, find, replace) {
	return string.replace(new RegExp(escapeRegExp(find), 'g'), replace);
}
function escapeRegExp(string) {
	return string.replace(/([.*+?^=!:${}()|\[\]\/\\])/g, "\\$1");
}
