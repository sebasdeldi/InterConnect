
// TABS LOGIC

document.addEventListener("turbolinks:load", function() {
	$('.tab').on('click', (e) => {
		var tabName = (e.currentTarget.attributes[0].nodeValue);
		document.cookie = "redirect_tab=";
		removeActive();
	  hideAll();
	  $('#' + tabName).addClass('is-active');
	  $('#' + tabName + '-content').removeClass('hidden');
	});

	var removeActive = () => {
	  $('li').each(function() {
	    $(this).removeClass('is-active');
	  });
	}

	var hideAll = () => {
	  $('#second-tab-content').addClass('hidden');
	  $('#first-tab-content').addClass('hidden');
	  $('#third-tab-content').addClass('hidden');
	  $('#fourth-tab-content').addClass('hidden');
	  $('#fifth-tab-content').addClass('hidden');
	}

	if (document.cookie.split(';').filter((item) => {
	  return item.includes('redirect_tab=operations_tab')
	}).length) {
  	document.cookie = "redirect_tab=";
  	removeActive();
    hideAll();
    $('#first-tab').addClass('is-active');
    $('#first-tab-content').removeClass('hidden');
	}
});
