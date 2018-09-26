
// TABS LOGIC

document.addEventListener("turbolinks:load", function() {

	if(($('.doc_hour')[0] == undefined) || ($('.doc_mins')[0] == undefined) || ($('.cargo_hour')[0] == undefined) || ($('.cargo_mins')[0] == undefined) || ($('.sailing_hour')[0] == undefined)|| ($('.sailing_mins')[0] == undefined) || ($('.arrival_hour')[0] == undefined)|| ($('.arrival_mins')[0] == undefined)){
		
	}


	var addBookingFields = (fields_number, data) => {

		var container = document.getElementById('pieces-container');
	  while (container.hasChildNodes()) {
	    container.removeChild(container.lastChild);
	  }
	  if ( data === undefined || data.length == 0){
	  	for (i=0; i < fields_number; i++){
	  	  var weight_field = document.createElement('div');
	  	  weight_field.innerHTML = ("<div class='box card-shadow margin-bottom'><div class='field'><label class='label'>Container # " + (i+1) + " Gross Weight (pounds)</label><div class='control has-icons-left'><input class='input' name='weight-" + (i + 1)  +"><span class='icon is-small is-left'><i class='fas fa-weight'></i></span></div></div><div class='field'><label class='label'>Container # " + (i+1) + " Commercial Description</label><div class='control has-icons-left'><input class='input' name='commercial-description-" + (i + 1) + "'"  + "><span class='icon is-small is-left'><i class='fas fa-weight'></i></span></div></div><div class='field container_type full-select'><label class='label'>Piece # " + (i+1) + " Container Type</label><div class='control'><div class='select full-select'><select class='full-select container-type-" +i+"'"+" name='container-type-" + (i + 1) + "'"  + "><option>20'</option><option>40'</option><option>40' HC</option><option>45'</option> <option>45' HC</option> <option>20' NOR</option> <option>40' NOR</option> <option>20' Flat Rack</option><option>40' Flat Rack</option> <option>20' Open Top</option> <option>40' Open Top</option></select></div></div><br><div class='field cargo_hazardous full-select'><label class='label'>Is Cargo # " + (i+1) + " Hazardous?</label><div class='control'><div class='select full-select'><select class='full-select hazardous-select cargo-hazardous-"+i +"'"+" name='is-hazardous" + (i + 1) + "'" + "><option>YES</option><option>NO</option></select></div></div><div class='field'><label class='label'>Container # " + (i+1) + " Hazard Class</label><div class='control has-icons-left'><input class='input' name='hazard-class-" + (i + 1) + "'"  + "><span class='icon is-small is-left'><i class='fas fa-exclamation-triangle'></i></span></div></div><div class='field'><label class='label'>Container # " + (i+1) + " Un-Code</label><div class='control has-icons-left'><input class='input' name='un-code-" + (i + 1) + "'" +"><span class='icon is-small is-left'><i class='fas fa-exclamation-triangle'></i></span></div><div class='field'><label class='label'>Container # " + (i+1) + " Container Number</label><div class='control has-icons-left'><input class='input' name='container-number-" + (i + 1) +"><span class='icon is-small is-left'><i class='fas fa-exclamation-triangle'></i></span></div></div><div class='field'><label class='label'>Container # " + (i+1) + " Seal Number</label><div class='control has-icons-left'><input class='input' name='seal-number-" + (i + 1) + "'"  + "'" +"><span class='icon is-small is-left'><i class='fas fa-exclamation-triangle'></i></span></div></div><div class='field'><label class='label'>Container # " + (i+1) + " Tare Weight</label><div class='control has-icons-left'><input class='input' name='tare-weight-" + (i + 1) + "'"+"><span class='icon is-small is-left'><i class='fas fa-exclamation-triangle'></i></span></div></div></div></div></div><br>");
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
	  	  weight_field.innerHTML = ("<div class='box card-shadow margin-bottom'><div class='field'><label class='label'>Container # " + (i+1) + " Gross Weight (pounds)</label><div class='control has-icons-left'><input class='input' name='weight-" + (i + 1) + "' value='" + data[i].gross_weight + "'" +"><span class='icon is-small is-left'><i class='fas fa-weight'></i></span></div></div><div class='field'><label class='label'>Container # " + (i+1) + " Commercial Description</label><div class='control has-icons-left'><input class='input' name='commercial-description-" + (i + 1) + "'" + "' value='" + data[i].commercial_description + "'" + "><span class='icon is-small is-left'><i class='fas fa-weight'></i></span></div></div><div class='field container_type full-select'><label class='label'>Piece # " + (i+1) + " Container Type</label><div class='control'><div class='select full-select'><select class='full-select container-type-" +i+"'"+" name='container-type-" + (i + 1) + "'"  + "><option>20'</option><option>40'</option><option>40' HC</option><option>45'</option> <option>45' HC</option> <option>20' NOR</option> <option>40' NOR</option> <option>20' Flat Rack</option><option>40' Flat Rack</option> <option>20' Open Top</option> <option>40' Open Top</option></select></div></div><br><div class='field cargo_hazardous full-select'><label class='label'>Is Cargo # " + (i+1) + " Hazardous?</label><div class='control'><div class='select full-select'><select class='full-select hazardous-select cargo-hazardous-"+i +"'"+" name='is-hazardous" + (i + 1) + "'" + "><option>YES</option><option>NO</option></select></div></div><div class='field'><label class='label'>Container # " + (i+1) + " Hazard Class</label><div class='control has-icons-left'><input class='input' name='hazard-class-" + (i + 1) + "'" + "' value='" + data[i].hazardous_class + "'" + "><span class='icon is-small is-left'><i class='fas fa-exclamation-triangle'></i></span></div></div><div class='field'><label class='label'>Container # " + (i+1) + " Un-Code</label><div class='control has-icons-left'><input class='input' name='un-code-" + (i + 1) + "'" + "' value='" + data[i].un_code + "'" +"><span class='icon is-small is-left'><i class='fas fa-exclamation-triangle'></i></span></div><div class='field'><label class='label'>Container # " + (i+1) + " Container Number</label><div class='control has-icons-left'><input class='input' name='container-number-" + (i + 1) + "'" + "' value='" + data[i].container_number + "'" +"><span class='icon is-small is-left'><i class='fas fa-exclamation-triangle'></i></span></div></div><div class='field'><label class='label'>Container # " + (i+1) + " Seal Number</label><div class='control has-icons-left'><input class='input' name='seal-number-" + (i + 1) + "'" + "' value='" + data[i].seal_number + "'" +"><span class='icon is-small is-left'><i class='fas fa-exclamation-triangle'></i></span></div></div><div class='field'><label class='label'>Container # " + (i+1) + " Tare Weight</label><div class='control has-icons-left'><input class='input' name='tare-weight-" + (i + 1) + "'" + "' value='" + data[i].tare_weight + "'" +"><span class='icon is-small is-left'><i class='fas fa-exclamation-triangle'></i></span></div></div></div></div></div><br>");
	  	  container.appendChild(weight_field);
	  	  $('.cargo-hazardous-'+i).val(data[i].cargo_hazardous);
	  	  $('.container-type-'+i).val(data[i].container_size);
	  	}
	  }

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
});


