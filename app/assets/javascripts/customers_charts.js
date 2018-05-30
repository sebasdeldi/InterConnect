
document.addEventListener("turbolinks:load", function() {

	if ($('#representative_id').val() == '' || $('#customer_id').val() == ''){
		$('.list-records').attr('disabled', 'disabled');
	}

});
