

var ready = () => {

	$(function() {
		alert('lol')
	  $('.submit').click(function() {
	    $('.new_user_import').submit();
	    $('.submit').addClass('is-loading');
	  });
	});


}

$(document).ready(ready);
$(document).on("page:load", ready);