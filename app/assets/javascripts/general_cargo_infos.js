
// GENERAL INFO FORM CHOOSING LOGIC


var ready = () => {

	$('.form-button').on('click', (e) => {
		var formName = (e.currentTarget.attributes[1].nodeValue);
		console.log (formName);
		hideAll();
	  $('#' + formName).removeClass('hidden');
	});

	var hideAll = () => {
	  $('#different-info').addClass('hidden');
	  $('#grouped-info').addClass('hidden');
	  $('#type-info').addClass('hidden');
	}

}

$(document).ready(ready);
$(document).on("page:load", ready);