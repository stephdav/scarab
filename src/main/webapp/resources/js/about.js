(function(){

	var aboutModalDomElt =
		  '<div id="about-modal" class="modal fade">'
		+ ' <div class="modal-dialog modal-lg" role="dialog" aria-labelledby="about-modal-title" aria-hidden="true">'
		+ '	 <div class="modal-content">'
		+ '	  <div class="modal-header"><h4 id="about-modal-title" class="modal-title"></h4></div>'
		+ '	  <div class="modal-body"><blockquote id="about-modal-content"></blockquote></div>'
		+ '	 </div>'
		+ ' </div>'
		+ '</div>';

	$aboutModalElt = $('body').find('#about-modal');
	if ($aboutModalElt.length == 0) {
		$('body').append(aboutModalDomElt);
	}

	$('#about-scarab').on("click", function(){
		var content = [];
		content.push('For <strong>agile teams</strong><br>who need a quick starter kit to assist them in their distributed concerns,<br><strong>Scarab</strong> is an agile software<br>that is <strong>simple</strong> to install, cover every <strong>scrum</strong> ideas, help to make the right <strong>strategy</strong>.');
		content.push('Unlike JIRA Agile (too many customization for permissions, workflows) or scrumwise (not full functional),<br>Scarab is <strong>simple and consistent</strong> to assist the teams all along their projects.');
		showAboutModal('About Scarab', content, '<a href="mailto:#">stephane.david@sopra.com</a>');
	});

})();

function showAboutModal(title, content, footer) {
	$('#about-modal-title').text(title);
	$('#about-modal-content').empty();
	var elt = '';
	$.each(content, function(i, p){
		elt += '<p>' + p + '</p>';
	});
	elt += '<footer>' + footer + '</footer>'
	$('#about-modal-content').append(elt);
	$('#about-modal').modal('show');
}
