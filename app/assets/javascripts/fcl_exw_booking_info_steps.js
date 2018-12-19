
// TABS LOGIC

document.addEventListener("turbolinks:load", function() {

	if(($('.doc_hour')[0] == undefined) || ($('.doc_mins')[0] == undefined) || ($('.cargo_hour')[0] == undefined) || ($('.cargo_mins')[0] == undefined) || ($('.sailing_hour')[0] == undefined)|| ($('.sailing_mins')[0] == undefined) || ($('.arrival_hour')[0] == undefined)|| ($('.arrival_mins')[0] == undefined)){
		
	}

	const container = document.getElementById('pieces-container');

	var addBookingFields = (fields_number, data) => {
		if (container !== null ){
		  while (container.hasChildNodes()) {
		    container.removeChild(container.lastChild);
		  }
		}
	  if ( data === undefined || data.length == 0){
	  	for (i=0; i < fields_number; i++){
	  	  var weight_field = document.createElement('div');
	  	  weight_field.innerHTML = ("<div class='box card-shadow margin-bottom'><div class='columns'><div class='column is-11'><div class='field'><label class='label'>Container # " + (i+1) + " Gross Weight (pounds)</label><div class='control has-icons-left'><input class='input' name='weight-" + (i + 1)  +"><span class='icon is-small is-left'><i class='fas fa-weight'></i></span></div></div></div><div class='column is-1'><br><a class='show-modal gross-weight'><i class='fas fa-info-circle guide-btn gross-weight'></i></a></div></div><div class='columns'><div class='column is-11'><div class='field'><label class='label'>Container # " + (i+1) + " Commercial Description</label><div class='control has-icons-left'><input class='input' name='commercial-description-" + (i + 1) + "'"  + "><span class='icon is-small is-left'><i class='fas fa-weight'></i></span></div></div></div><div class='column is-1'><br><a class='show-modal gross-weight'><i class='fas fa-info-circle guide-btn gross-weight'></i></a></div></div><div class='columns'><div class='column is-11'><div class='field container_type full-select'><label class='label'>Container # " + (i+1) + " Size</label><div class='control'><div class='select full-select'><select class='full-select container-type-" +i+"'"+" name='container-type-" + (i + 1) + "'"  + "><option>20'</option><option>40'</option><option>40' HC</option><option>45'</option><option>45' HC</option><option>20' NOR</option><option>40' NOR</option><option>20' Flat Rack</option><option>40' Flat Rack</option><option>20' Open Top</option><option>40' Open Top</option></select></div></div></div></div><div class='column is-1'><br><a class='show-modal gross-weight'><i class='fas fa-info-circle guide-btn gross-weight'></i></a></div></div><div class='columns'><div class='column is-11'><div class='field cargo_hazardous full-select'><label class='label'>Is Cargo # " + (i+1) + " Hazardous?</label><div class='control'><div class='select full-select'><select class='full-select hazardous-select cargo-hazardous-"+i +"'"+" name='is-hazardous" + (i + 1) + "'" + "><option>NO</option><option>YES</option></select></div></div></div></div><div class='column is-1'><br><a class='show-modal gross-weight'><i class='fas fa-info-circle guide-btn gross-weight'></i></a></div></div><div class='columns'><div class='column is-11'><div class='field'><label class='label'>Container # " + (i+1) + " Hazard Class</label><div class='control has-icons-left'><input class='input' name='hazard-class-" + (i + 1) + "'"  + "><span class='icon is-small is-left'><i class='fas fa-exclamation-triangle'></i></span></div></div></div><div class='column is-1'><br><a class='show-modal gross-weight'><i class='fas fa-info-circle guide-btn gross-weight'></i></a></div></div><div class='columns'><div class='column is-11'><div class='field'><label class='label'>Container # " + (i+1) + " Un-Code</label><div class='control has-icons-left'><input class='input' name='un-code-" + (i + 1) + "'" +"><span class='icon is-small is-left'><i class='fas fa-exclamation-triangle'></i></span></div></div></div><div class='column is-1'><br><a class='show-modal gross-weight'><i class='fas fa-info-circle guide-btn gross-weight'></i></a></div></div><div class='columns'><div class='column is-11'><div class='field'><label class='label'>Container # " + (i+1) + " Container Number</label><div class='control has-icons-left'><input class='input' name='container-number-" + (i + 1) +"><span class='icon is-small is-left'><i class='fas fa-exclamation-triangle'></i></span></div></div></div><div class='column is-1'><br><a class='show-modal gross-weight'><i class='fas fa-info-circle guide-btn gross-weight'></i></a></div></div><div class='columns'><div class='column is-11'><div class='field'><label class='label'>Container # " + (i+1) + " Seal Number</label><div class='control has-icons-left'><input class='input' name='seal-number-" + (i + 1) + "'"  + "'" +"><span class='icon is-small is-left'><i class='fas fa-exclamation-triangle'></i></span></div></div>      </div><div class='column is-1'><br><a class='show-modal gross-weight'><i class='fas fa-info-circle guide-btn gross-weight'></i></a></div></div><div class='columns'><div class='column is-11'><div class='field'><label class='label'>Container # " + (i+1) + " Tare Weight</label><div class='control has-icons-left'><input class='input' name='tare-weight-" + (i + 1) + "'"+"><span class='icon is-small is-left'><i class='fas fa-exclamation-triangle'></i></span></div></div>      </div><div class='column is-1'><br><a class='show-modal tare-weight'><i class='fas fa-info-circle guide-btn tare-weight'></i></a></div></div></div></div></div><br>");
	  	  container.appendChild(weight_field);
	  	}
	  } else {
	  	for (i=0; i < fields_number; i++){
	  		if (data[i].container_number == null){
	  			data[i].container_number = ''
	  		}
	  		if (data[i].seal_number == null){
	  			data[i].seal_number = ''
	  		}
	  		if (data[i].tare_weight == null){
	  			data[i].tare_weight = ''
	  		}
	  	  var weight_field = document.createElement('div');
	  	  weight_field.innerHTML = ("<div class='box card-shadow margin-bottom'><div class='columns'><div class='column is-11'><div class='field'><label class='label'>Container # " + (i+1) + " Gross Weight (pounds)</label><div class='control has-icons-left'><input class='input' name='weight-" + (i + 1) + "' value='" + data[i].gross_weight + "'" +"><span class='icon is-small is-left'><i class='fas fa-weight'></i></span></div></div></div><div class='column is-1'><br><a class='show-modal gross-weight'><i class='fas fa-info-circle guide-btn gross-weight'></i></a></div></div><div class='columns'><div class='column is-11'><div class='field'><label class='label'>Container # " + (i+1) + " Commercial Description</label><div class='control has-icons-left'><input class='input' name='commercial-description-" + (i + 1) + "'" + "' value='" + data[i].commercial_description + "'" + "><span class='icon is-small is-left'><i class='fas fa-weight'></i></span></div></div></div><div class='column is-1'><br><a class='show-modal commercial-description'><i class='fas fa-info-circle guide-btn commercial-description'></i></a></div></div><div class='columns'><div class='column is-11'><div class='field container_type full-select'><label class='label'>Container # " + (i+1) + " Size</label><div class='control'><div class='select full-select'><select class='full-select container-type-" +i+"'"+" name='container-type-" + (i + 1) + "'"  + "><option>20'</option><option>40'</option><option>40' HC</option><option>45'</option><option>45' HC</option><option>20' NOR</option><option>40' NOR</option><option>20' Flat Rack</option><option>40' Flat Rack</option><option>20' Open Top</option><option>40' Open Top</option></select></div></div></div></div><div class='column is-1'><br><a class='show-modal container-type'><i class='fas fa-info-circle guide-btn container-type'></i></a></div></div><div class='columns'><div class='column is-11'><div class='field cargo_hazardous full-select'><label class='label'>Is Cargo # " + (i+1) + " Hazardous?</label><div class='control'><div class='select full-select'><select class='full-select hazardous-select cargo-hazardous-"+i +"'"+" name='is-hazardous" + (i + 1) + "'" + "><option>NO</option><option>YES</option></select></div></div></div></div><div class='column is-1'><br><a class='show-modal is-hazard'><i class='fas fa-info-circle guide-btn cargo-hazardous'></i></a></div></div><div class='columns'><div class='column is-11'><div class='field'><label class='label'>Container # " + (i+1) + " Hazard Class</label><div class='control has-icons-left'><input class='input' name='hazard-class-" + (i + 1) + "'" + "' value='" + data[i].hazardous_class + "'" + "><span class='icon is-small is-left'><i class='fas fa-exclamation-triangle'></i></span></div></div></div><div class='column is-1'><br><a class='show-modal hazard-class'><i class='fas fa-info-circle guide-btn hazard-class'></i></a></div></div><div class='columns'><div class='column is-11'><div class='field'><label class='label'>Container # " + (i+1) + " Un-Code</label><div class='control has-icons-left'><input class='input' name='un-code-" + (i + 1) + "'" + "' value='" + data[i].un_code + "'" +"><span class='icon is-small is-left'><i class='fas fa-exclamation-triangle'></i></span></div></div></div><div class='column is-1'><br><a class='show-modal un-code'><i class='fas fa-info-circle guide-btn un-code'></i></a></div></div><div class='columns'><div class='column is-11'><div class='field'><label class='label'>Container # " + (i+1) + " Container Number</label><div class='control has-icons-left'><input class='input' name='container-number-" + (i + 1) + "'" + "' value='" + data[i].container_number + "'" +"><span class='icon is-small is-left'><i class='fas fa-exclamation-triangle'></i></span></div></div></div><div class='column is-1'><br><a class='show-modal container-number'><i class='fas fa-info-circle guide-btn container-number'></i></a></div></div><div class='columns'><div class='column is-11'><div class='field'><label class='label'>Container # " + (i+1) + " Seal Number</label><div class='control has-icons-left'><input class='input' name='seal-number-" + (i + 1) + "'" + "' value='" + data[i].seal_number + "'" +"><span class='icon is-small is-left'><i class='fas fa-exclamation-triangle'></i></span></div></div></div><div class='column is-1'><br><a class='show-modal seal-number'><i class='fas fa-info-circle guide-btn seal-number'></i></a></div></div><div class='columns'><div class='column is-11'><div class='field'><label class='label'>Container # " + (i+1) + " Tare Weight</label><div class='control has-icons-left'><input class='input' name='tare-weight-" + (i + 1) + "'" + "' value='" + data[i].tare_weight + "'" +"><span class='icon is-small is-left'><i class='fas fa-exclamation-triangle'></i></span></div></div></div><div class='column is-1'><br><a class='show-modal tare-weight'><i class='fas fa-info-circle guide-btn tare-weight'></i></a></div></div></div></div></div><br>");
	  	  container.appendChild(weight_field);
	  	  $('.cargo-hazardous-'+i).val(data[i].cargo_hazardous);
	  	  $('.container-type-'+i).val(data[i].container_size);
	  	}
	  }
	  hideHazFieldsWhenSaved();
	} 

	// Multiple containers generator
	$('.pieces-number-booking').on("change keydown paste input", () => {
		addBookingFields($('.input.pieces-number-booking').val(), []);
	});

	$.ajax({
	  type: "POST",
	  url: "/pieces_for_cargo_info",
	  data: { fcl_exw_cargo_info_step_id: $('.fcl_exw_cargo_info_step_id').val() },
	  success: function(data){
	  	if(data[data.length-1] === 'update'){
	  		addBookingFields($('.input.pieces-number-booking').val(), data);
	  	}else{

	  	}
		},
		error: function(data){
  		console.log('error')
		}   
	});
	


	$('select').onchange = function() {
    var value = $(this).children(":selected").attr("value");
	}

	var showRamp = () => {
		if ($(".ramp").val() == 'YES'){
		  $(".ramp-cut-off-container").removeClass('hidden');
		} else {
		  $(".ramp-cut-off").val('');
		  $(".ramp-cut-off-container").addClass('hidden');
		}
	}

	showRamp();

	$(".ramp").on('change', function(){
	  showRamp();
	})


	if($('.doc_hour')[0] != undefined){
		var doc_hours = $('.doc_hour')[0].innerHTML
		var doc_minutes = $('.doc_mins')[0].innerHTML

		var cargo_hours = $('.cargo_hour')[0].innerHTML
		var cargo_minutes = $('.cargo_mins')[0].innerHTML

		var sailing_hours = $('.sailing_hour')[0].innerHTML
		var sailing_minutes = $('.sailing_mins')[0].innerHTML

		var arrival_hours = $('.arrival_hour')[0].innerHTML
		var arrival_minutes = $('.arrival_mins')[0].innerHTML

		if (doc_hours.length == 1){
		  doc_hours = '0' + doc_hours
		}
		
		if (doc_minutes.length == 1){
		  doc_minutes = '0' + doc_minutes
		}

		if (cargo_hours.length == 1){
		  cargo_hours = '0' + cargo_hours
		}
		
		if (cargo_minutes.length == 1){
		  cargo_minutes = '0' + cargo_minutes
		}

		if (sailing_hours.length == 1){
		  sailing_hours = '0' + sailing_hours
		}
		
		if (sailing_minutes.length == 1){
		  sailing_minutes = '0' + sailing_minutes
		}

		if (arrival_hours.length == 1){
		  arrival_hours = '0' + arrival_hours
		}
		
		if (arrival_minutes.length == 1){
		  arrival_minutes = '0' + arrival_minutes
		}

		$('#fcl_exw_booking_info_step_doc_cut_off_time_4i').val(doc_hours);
		$('#fcl_exw_booking_info_step_doc_cut_off_time_5i').val(doc_minutes);

		$('#fcl_exw_booking_info_step_cargo_cut_off_time_4i').val(cargo_hours);
		$('#fcl_exw_booking_info_step_cargo_cut_off_time_5i').val(cargo_minutes);

		$('#fcl_exw_booking_info_step_sailing_time_4i').val(sailing_hours);
		$('#fcl_exw_booking_info_step_sailing_time_5i').val(sailing_minutes);

		$('#fcl_exw_booking_info_step_arrival_time_4i').val(arrival_hours);
		$('#fcl_exw_booking_info_step_arrival_time_5i').val(arrival_minutes);
	}

	function hideHazFieldsWhenSaved(){
		if($('#pieces-container')[0] !== undefined){
		  for (i=0; i < $('#pieces-container')[0].childNodes.length; i++) {
		  	haz = $('#pieces-container')[0].children[i].children[0].children[3].children[0].children[0].children[1].children[0].firstChild;
		  	hazClass = haz.parentNode.parentNode.parentNode.parentNode.parentNode.nextSibling.classList;
		  	unCode = haz.parentNode.parentNode.parentNode.parentNode.parentNode.nextSibling.nextSibling.classList;
		  	if(haz.value === "YES"){
			  	hazClass.remove("hidden");
					unCode.remove("hidden");
		  	}else{
			  	hazClass.add("hidden");
					unCode.add("hidden");
		  	}
		  }
		}
	} 

	function activateGuide (event) {
		classList = event.target.parentElement.classList
	  value = classList[classList.length-1];
	  if(value.includes('gross')){
  	  $(".modal.gross-weight").addClass("is-active"); 
	  }else if(value.includes('commercial-description')){
	  	$(".modal.commercial-description").addClass("is-active"); 
	  }else if(value.includes("container-type")){
	  	$(".modal.container-type").addClass("is-active")
	  }else if(value.includes('is-hazard')){
	  	$(".modal.cargo-hazardous").addClass("is-active")
	  }else if(value.includes('hazard-class')){
	  	$(".modal.hazard-class").addClass("is-active")
	  }else if(value.includes('un-code')){
	  	$(".modal.un-code").addClass("is-active")
	  }else if(value.includes('seal')){
	  	$(".modal.seal-number").addClass("is-active")
	  }else if(value.includes('tare')){
	  	$(".modal.tare-weight").addClass("is-active")
	  }else if(value.includes('container-number')){
	  	$(".modal.container-number").addClass("is-active")
	  }
	}

	function hazardousFields (event){
		value = event.target.value;
		hazSelectDetector = event.target.firstChild
		if (hazSelectDetector === null) {
			hazSelectDetector = 'null'
		}else{
			hazSelectDetector = hazSelectDetector.value
		}
		if(hazSelectDetector === "NO"){
			hazClass = event.target.parentNode.parentNode.parentNode.parentNode.parentNode.nextSibling;
			unCode = event.target.parentNode.parentNode.parentNode.parentNode.parentNode.nextSibling.nextSibling;
		  if(value === "YES"){
		  	hazClass.classList.remove("hidden");
				unCode.classList.remove("hidden");
		  }else if(value === "NO"){
		  	hazClass.classList.add("hidden");
		  	unCode.classList.add("hidden");
		  	hazClass.children[0].children[0].children[1].children[0].value = '';
		  	unCode.children[0].children[0].children[1].children[0].value = '';
		  }
		}
	}

	if (container !== null){
		container.addEventListener('click', activateGuide)
		container.addEventListener('change', hazardousFields)
	}

});


