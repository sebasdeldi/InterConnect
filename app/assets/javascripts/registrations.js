
var ready = () => {

	$(".new_user").on("ajax:success", function(event) {
		var detail = event.detail;
		var data = detail[0], status = detail[1],  xhr = detail[2];
  	console.log(data.success)
	});
}

$(document).ready(ready);
$(document).on("page:load", ready);