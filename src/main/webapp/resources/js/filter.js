/**
 * List filtering
 */

/**
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