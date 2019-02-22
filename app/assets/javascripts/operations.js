

document.addEventListener("turbolinks:load", function() {
	// CLICKEABLE TABLE ROWS

	$('.row').on('click', (e) => {
		window.location = e.target.dataset.link;
	});

	$('.operations-redirection').on('click', (e) => {
		document.cookie = "redirect_tab=operations_tab";
	});

	//$('.carrier-select').prop('selectedIndex', 0); 

	if($('.carrier-select').val() != null){
		dataRequest();
	}

	function noCarrier(){
		if($('.carrier-select').val() == ""){
			$(".additional-message").hide();
			$(".carrier-info").hide();
			$(".request").hide();
			$(".website-redirect").hide();
			$(".notify-agent").hide();
		}
	}

	noCarrier();

	$('.wrlcl').on('click', function() {
		var redirectWindow = window.open('https://lfs.shipprimus.com/RatingApplet.php', '_blank');
		redirectWindow.location
	});
	
	$('.carrier-select').on('change', function() {
		dataRequest();
		noCarrier();
	});

	function redirect(website){
		$(".website-redirect").on('click', function() {
			var redirectWindow = window.open(website, '_blank');
			redirectWindow.location;
		});
	}


	function dataRequest(){
		$.ajax({
		  type: "POST",
		  url: "/carrier_info",
		  data: { carrier_id: $('.carrier-select').val() },
		  success: function(data){
		  	var options = '';
		  	var website = '';
		  	var trigger = false;
		  	for (var i = 0; i < data.length; i++) {
		  		if ( data[i].website !== "N/A"){
		  			trigger = true;
		  			website = data[i].website;
		  		}else{
		  			options = options + "<option value='" + data[i].id +"'>" + data[i].email + "</option>";  
		  		}
		  	}

		  	if(trigger){
		  		$(".hidden-website").val(website);
		  		$(".additional-message").hide();
		  		$(".carrier-info").hide();
		  		$(".request").hide();
		  		$(".website-redirect").show();
		  		$(".notify-agent").show();
		  		redirect(website);
		  	} else {
		  		$(".hidden-website").val("N/A");
		  		$(".additional-message").show();
		  		$(".carrier-info").show();
		  		$(".request").show();
		  		$(".website-redirect").hide();
		  		$(".notify-agent").show();
		  		$(".carrier-info").html('<label class="label">Contact:</label><div class="select full-select"><select name="carrier_contact_id" id="carrier_contact_id" class="full-select">' + options + '</select></div>')
		  	}
 			},
 			error: function(data){
		  	$(".carrier-info").html("")
 			}   
		});
	}

	// Change fields for each modality
	modality = $('#modality');
	pol_field = $('#port-loading');
	pod_field = $('#port-discharge');
	pol_group = $('.columns.pol');
	pod_group = $('.columns.pod');

	function change(modality, pol_field, pod_field, pol_group, pod_group){
		if (modality.val() == 'FCL - EXW'){
			pol_field.val('');
			pod_field.val('');
			pol_group.show();
			pod_group.show();
		} else if (modality.val() == 'LCL'){
			pol_field.val('xxx');
			pod_field.val('xxx');
			pol_group.hide();
			pod_group.hide();
		}
	}



	modality.on('change', function() {
		change(modality, pol_field, pod_field, pol_group, pod_group)
	});

	change(modality, pol_field, pod_field, pol_group, pod_group)

});
