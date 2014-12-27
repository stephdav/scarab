/**
 * Loader utilities
 */

var loader;
function useLoader(ajaxPath) {
	var loaderDOM = '<div id="ajaxLoader">' + '	<img src="' + ajaxPath
			+ '/resources/images/loader.gif"></img>' + '</div>';
	$loaderScarabElt = $('body').find('#ajaxLoader');
	if ($loaderScarabElt.length == 0) {
		$('body').append(loaderDOM);
	}
}
function startLoading() {
	loader = setTimeout('$("#ajaxLoader").show()', 1000);
}

function stopLoading() {
	clearTimeout(loader);
	$("#ajaxLoader").hide();
}

function detectLeaveForm() {
	var eltDOM = '<div id="intercept"></div>';
	$detectElt = $('body').find('#intercept');
	if ($detectElt.length == 0) {
		$('body').append(eltDOM);
	}
}

function startDetectLeaveForm() {
	// $("#intercept").css("z-index", 1050);
	// $("#refinementView .col-md-6").css("z-index", 1052);
}

function stopDetectLeaveForm() {
	// $("#intercept").css("z-index", -1);
	// $("#refinementView .col-md-6").css("z-index", 'auto');
}
/**
 * Navigation utilities
 */
function scrollToTop() {
	$('html, body').animate({
		scrollTop : 0
	}, 'slow');
}

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

/**
 * Convert a timestamp in a readable date dd/MM/yyyy
 * 
 * @param selector
 *            DOM selector
 * @param timeInMillis
 *            timestamp
 */
function setDateValue(selector, timeInMillis) {
	var d = new Date(timeInMillis);
	var val = d.getDate() + '/' + (d.getMonth() + 1) + '/' + d.getFullYear();
	$(selector).text(val);
}

/**
 * Convert a timestamp in a readable date dd/MM/yyyy HH:MI
 * 
 * @param selector
 *            DOM selector
 * @param timeInMillis
 *            timestamp
 */
function setDateTimeValue(selector, timeInMillis) {
	var val = new Date(timeInMillis).toLocaleString();
	$(selector).text(val);
}
