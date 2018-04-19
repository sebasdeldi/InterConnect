
document.addEventListener("turbolinks:load", function() {

	$(function() {
	  $('.submit').click(function() {
	    $('.new_user_import').submit();
	    $('.submit').addClass('is-loading');
	  });
	});
});

