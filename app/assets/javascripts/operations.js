

document.addEventListener("turbolinks:load", function() {
	// CLICKEABLE TABLE ROWS

	$('.row').on('click', (e) => {
		window.location = e.target.dataset.link;
	});

	$('.operations-redirection').on('click', (e) => {
		document.cookie = "redirect_tab=operations_tab";
	});

	$('.carrier-select').prop('selectedIndex', 0); 
	
	$('.carrier-select').on('change', function() {
		$.ajax({
		  type: "POST",
		  url: "/carrier_info",
		  data: { carrier_id: $('.carrier-select').val() },
		  success: function(data){
		  	var options = '';
		  	for (var i = 0; i < data.length; i++) {
		  		console.log(i)
		  		options = options + "<option value='" + data[i].id +"'>" + data[i].email + "</option>"  
		  	}
 				$(".carrier-info").html('<label class="label">Contact:</label><div class="select full-select"><select name="carrier_contact_id" id="carrier_contact_id" class="full-select">' + options + '</select></div>')
 			},
 			error: function(data){
		  	$(".carrier-info").html("")
 			}   
		});
	});

});
