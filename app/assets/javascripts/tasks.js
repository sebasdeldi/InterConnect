
document.addEventListener("turbolinks:load", function() {

	$(".due_datetime").datepicker({
  	todayHighlight: true,
  	format:'dd-mm-yy',
  	autoclose:true
	});

	$('.due_datetime').on('change', function() {
		var date = $(".due_datetime").val().split('/');
		var temp = date[0];
		date[0] = date[1];
		date[1] = temp;
		date = date.join('-');
		$('.due_datetime').val(date);
	});


});

