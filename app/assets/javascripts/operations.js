

document.addEventListener("turbolinks:load", function() {
	// CLICKEABLE TABLE ROWS

	$('.row').on('click', (e) => {
		window.location = e.target.dataset.link;
	});

	$('.operations-redirection').on('click', (e) => {
		document.cookie = "redirect_tab=operations_tab";
	});

	$('.modality').prop('selectedIndex', 0); 

	$('.carrier-select').prop('selectedIndex', 0); 
	
	$('.carrier-select').on('change', function() {
		$.ajax({
		  type: "POST",
		  url: "/carrier_info",
		  data: { carrier_id: $('.carrier-select').val() },
		  success: function(data){
		  	$(".carrier-info").html("<article class='message is-primary'><div class='message-header'><p><i class='fas fa-exclamation-triangle'> </i>CARRIER INFORMATION</p></div><div class='message-body'><li><b>Carrier Name: </b>"+ data.company_name +"</li>" +"<li><b>Email Address: </b>"+ data.email +"</li>" + "<li><b>Phone Number: </b>"+ data.phone_number +"</li></div></article>")
 			},
 			error: function(data){
		  	$(".carrier-info").html("")
 			}   
		});
	});

});
