
document.addEventListener("turbolinks:load", function() {
	$(".loading_datetime").datepicker({
  	dateFormat: "yy-mm-dd"
	});

	// Multiple containers generator

	$('.pieces-number-diff').on("change keydown paste input", () => {
		addFields($('.input.pieces-number-diff').val())
	});

	var addFields = (fields_number) => {
	  var container = document.getElementById('container');
	  while (container.hasChildNodes()) {
	    container.removeChild(container.lastChild);
	  }
	  for (i=0; i < fields_number; i++){
	    var weight_field = document.createElement('div');
	    weight_field.innerHTML = ("<div class='box card-shadow margin-bottom'><div class='field'><label class='label'>Container # " + (i+1) + " Gross Weight (pounds)</label><div class='control has-icons-left'><input class='input' name='weight-" + (i + 1) + "'" + "><span class='icon is-small is-left'><i class='fas fa-weight'></i></span></div></div><div class='field'><label class='label'>Container # " + (i+1) + " Commercial Description</label><div class='control has-icons-left'><input class='input' name='commercial-description-" + (i + 1) + "'" + "><span class='icon is-small is-left'><i class='fas fa-weight'></i></span></div></div><div class='field container_type full-select'><label class='label'>Piece # " + (i+1) + " Container Type</label><div class='control'><div class='select full-select'><select class='full-select' name='container-type-" + (i + 1) + "'" + "><option>20</option><option>20' HC</option><option>40'</option><option>40' HC</option><option>45'</option> <option>45' HC</option> <option>20' NOR</option> <option>40' NOR</option> <option>20' Flat Rack</option><option>40' Flat Rack</option> <option>20' Open Top</option> <option>40' Open Top</option></select></div></div><br><div class='field cargo_hazardous full-select'><label class='label'>Is Cargo # " + (i+1) + " Hazardous?</label><div class='control'><div class='select full-select'><select class='full-select' name='is-hazardous" + (i + 1) + "'" + "><option>YES</option><option>NO</option></select></div></div></div></div><br>");
	    container.appendChild(weight_field);
	  }
	}

});

