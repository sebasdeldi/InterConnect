
// TABS LOGIC

document.addEventListener("turbolinks:load", function() {
	$('.tab').on('click', (e) => {
		var tabName = (e.currentTarget.attributes[0].nodeValue);
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
	}
});
