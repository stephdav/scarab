function activateEstimateTool() {
	$("#estimateTool").on("click", ".voteTool .vtMinus", function() {
		var estimate = $(this).closest(".voteTool").find(".vtEstimate").text();
		var domVal = $(this).closest(".voteTool").find(".vtContent");
		var curVal = parseInt($(domVal).text());
		if (curVal > 0) {
			curVal -= 1;
		}
		$(domVal).text(curVal);
		getHigherEstimate();
	});
	$("#estimateTool").on("click", ".voteTool .vtPlus", function() {
		var estimate = $(this).closest(".voteTool").find(".vtEstimate").text();
		var domVal = $(this).closest(".voteTool").find(".vtContent");
		var curVal = parseInt($(domVal).text());
		curVal += 1;
		$(domVal).text(curVal);
		getHigherEstimate();
	});
}

var previousHighestEstimate = -1;
function getHigherEstimate() {
	var highest = -1;
	var estimate = 0;
	$('.vtContent').each(function(){
		var val = $(this).text();
		if (val > highest) {
			highest = val;
			estimate = $(this).closest('tr.voteTool').find('.vtEstimate').text();
		}
	});
	if (highest >= 0 && estimate != previousHighestEstimate) {
		$('.vtContent').each(function(){
			$(this).removeClass('higestEstimate');
			var val = $(this).text();
			if (val == highest) {
				highest = val;
				$(this).addClass('higestEstimate');
			}
		});
		loadStoriesWithSameEstimate(estimate);
		previousHighestEstimate = estimate;
	}
}

function loadStoriesWithSameEstimate(estimate) {
	$.getJSON(ajaxPath + '/rest/us/estimate/' + estimate, function(data) {
		$('#voteResult').empty();
		var elt = '<li class="list-group-item"><div class="list-table-cell">most recent stories with same estimate (' + estimate + ')</div></li>';
		if (typeof (data) != 'undefined') {
			if (data.length > 0) {
				$.each(data, function(i, us) {
					elt += '<li class="list-group-item"><div class="list-table-cell">'
					if (typeof (us.code) != 'undefined' && us.code != '') {
						elt += '[' + us.code + '] ';
					}
					elt += us.title + '</div></li>';
				});
			} else {
				elt += '<li class="list-group-item"><div class="list-table-cell">-</div></li>';
			}
		}
		$('#voteResult').append(elt);
	});
}

