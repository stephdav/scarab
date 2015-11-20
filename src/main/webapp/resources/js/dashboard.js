$(function() {
	//getPolarData("#myChart", $("#projectId").val());
	getBarData("#myChart", $("#projectId").val());
	getDonutsData("#myChart1", $("#projectId").val(), "status");
	getDonutsData("#myChart2", $("#projectId").val(), "category");
	getDonutsData("#myChart3", $("#projectId").val(), "user");
});

function getPolarData(selector, id) {
	apiProjectDashboardCycleTime(id, function(data) {
		var ctx = $(selector).get(0).getContext("2d");
		var myNewChart = new Chart(ctx);
		myNewChart.PolarArea(data);
	}, function(textStatus, errorThrown) {
		showAlertError('Failed to get data');
	});
}

function getBarData(selector, id) {
	apiProjectDashboardCycleTimeBar(id, function(data) {
		var ctx = $(selector).get(0).getContext("2d");
		var myNewChart = new Chart(ctx);
		myNewChart.Bar(data);
	}, function(textStatus, errorThrown) {
		showAlertError('Failed to get data');
	});
}

function getDonutsData(selector, id, fieldname) {
	apiProjectDashboardDoughnut(id, fieldname, function(data) {
		var ctx = $(selector).get(0).getContext("2d");
		var myNewChart = new Chart(ctx);
		myNewChart.Doughnut(data);
	}, function(textStatus, errorThrown) {
		showAlertError('Failed to get data');
	});
}