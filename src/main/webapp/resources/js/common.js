/**
 * Text utilities
 */

/**
 * Convert multiline value into string.
 * 
 * @param selector
 *            textarea selector
 */
function getTextAreaValue(selector) {
	var val = $(selector).val();
	return val.replace(/(\r\n|\n\r|\r|\n)/g, '<br>');
}

/**
 * Convert string with multiple lines into textarea value.
 * 
 * @param selector
 *            textarea selector
 * @param text
 *            text to set
 */
function setTextAreaValue(selector, text) {
	var val = text.replace(/<br>/g, '\n');
	$(selector).text(val);
}
