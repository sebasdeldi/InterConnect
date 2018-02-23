
// TABS LOGIC


var ready = () => {

	$('.tab').on('click', (e) => {
		var tabName = (e.currentTarget.attributes[0].nodeValue);
		removeActive();
	  hideAll();
	  console.log(tabName)
	  $('#' + tabName).addClass('is-active');
	  $('#' + tabName + '-content').removeClass('hidden');
	});

	var removeActive = () => {
	  $('li').each(function() {
	    $(this).removeClass('is-active');
	  });
	}

	var hideAll = () => {
	  $('#registerAgent-tab-content').addClass('hidden');
	  $('#insights-tab-content').addClass('hidden');
	  $('#options-tab-content').addClass('hidden');
	}

}

$(document).ready(ready);
$(document).on("page:load", ready);