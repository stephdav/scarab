(function(){

	var aboutModal = '<div id="aboutScarab" class="modal fade"><div class="modal-dialog modal-lg" role="dialog" aria-labelledby="modal-scarab-title" aria-hidden="true">'
		+ '	<div class="modal-content"><div class="modal-header"><h4 id="modal-scarab-title" class="modal-title">About Scarab</h4></div><div class="modal-body">'
		+ '		<blockquote>'
		+ '			<p>For <strong>agile teams</strong><br>who need a quick starter kit to assist them in their distributed concerns,<br><strong>Scarab</strong> is an agile software<br>that is <strong>simple</strong> to install, cover every <strong>scrum</strong> ideas, help to make the right <strong>strategy</strong>.<br></p>'
		+ '			<p>Unlike JIRA Agile (too many customization for permissions, workflows) or scrumwise (not full functional),<br>Scarab is <strong>simple and consistent</strong> to assist the teams all along their projects.<br></p>'
		+ '			<footer><a href="mailto:#">stephane.david@sopra.com</a></footer>'
		+ '		</blockquote>'
		+ '	</div></div>'
		+ '</div></div>';

	$aboutScarabElt = $('body').find('#aboutScarab');
	if ($aboutScarabElt.length == 0) {
		$('body').append(aboutModal);
	}

})();
