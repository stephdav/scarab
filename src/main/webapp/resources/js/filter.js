/**
 * List filtering
 */

/**
 * 	<div class="input-group input-group-sm">
 * 		<input type="text" id="us-input-search" class="form-control">
 * 		<span class="input-group-addon" style="width: auto;"><span class="glyphicon glyphicon-search"></span></span>
 * 	</div>
 * 	$('#us-input-search').on('keyup', function() { filterUS('#list-allUS', $(this).val()); });
 * 
 * @param exp ul selector
 */
function filterUS(selector, pattern) {
	// create regular expression based on the pattern
	var rex = new RegExp(pattern, 'i');

	// Hide all items except first line
	$(selector).find('li').hide();
	$(selector).find('li:first-child').show();
	
	// Show only items with text matching the pattern
	$(selector).find('li').filter(function() {
		return rex.test($(this).text());
	}).show();
}