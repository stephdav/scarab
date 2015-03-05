function activateEstimateTool() {
	$("#estimateTool").on("click", ".voteTool .vtMinus", function() {
		var estimate = $(this).closest(".voteTool").find(".vtEstimate").text();
		var domVal = $(this).closest(".voteTool").find(".vtContent");
		var curVal = parseInt($(domVal).text());
		if (curVal > 0) {
			curVal -= 1;
		}
		$(domVal).text(curVal);
	});
	$("#estimateTool").on("click", ".voteTool .vtPlus", function() {
		var estimate = $(this).closest(".voteTool").find(".vtEstimate").text();
		var domVal = $(this).closest(".voteTool").find(".vtContent");
		var curVal = parseInt($(domVal).text());
		curVal += 1;
		$(domVal).text(curVal);
	});
}
