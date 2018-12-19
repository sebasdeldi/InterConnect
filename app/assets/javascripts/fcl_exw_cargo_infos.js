
document.addEventListener("turbolinks:load", function() {

	$(".loading_datetime").datepicker({
  	dateFormat: "yy-mm-dd"
	});

	const container = document.getElementById('container');

	var addFields = (fields_number, data) => {

	  while (container.hasChildNodes()) {
	    container.removeChild(container.lastChild);
	  }
	  if ( data === undefined || data.length == 0){
	  	for (i=0; i < fields_number; i++){
	  	  var weight_field = document.createElement('div');
	  	  //for understaing the super long oneline html, copy and paste the line in https://www.freeformatter.com/html-formatter.html
	  	  weight_field.innerHTML = ("<div class='box card-shadow margin-bottom'><div class='columns'><div class='column is-11'><div class='field'><label class='label'>Container # " + (i+1) + " Gross Weight (lbs)</label><div class='control has-icons-left'><input class='input' name='weight-" + (i + 1) + "'" + "><span class='icon is-small is-left'><i class='fas fa-weight'></i></span></div></div></div><div class='column is-1'><br><a class='show-modal gross-weight'><i class='fas fa-info-circle guide-btn gross-weight'></i></a></div></div><div class='columns'><div class='column is-11'><div class='field'><label class='label'>Container # " + (i+1) + " Commercial Description</label><div class='control has-icons-left'><input class='input' name='commercial-description-" + (i + 1) + "'" + "><span class='icon is-small is-left'><i class='fas fa-weight'></i></span></div></div></div><div class='column is-1'><br><a class='show-modal commercial-description'><i class='fas fa-info-circle guide-btn'></i></a></div></div><div class='columns'><div class='column is-11'><div class='field container_type full-select'><label class='label'>Piece # " + (i+1) + " Container Type</label><div class='control'><div class='select full-select'><select class='full-select' name='container-type-" + (i + 1) + "'" + "><option>20'</option><option>40'</option><option>40' HC</option><option>45'</option><option>45' HC</option><option>20' NOR</option><option>40' NOR</option><option>20' Flat Rack</option><option>40' Flat Rack</option><option>20' Open Top</option><option>40' Open Top</option></select></div></div></div></div><div class='column is-1'><br><a class='show-modal container-type'><i class='fas fa-info-circle guide-btn'></i></a></div></div><br><div class='columns'><div class='column is-11'><div class='field cargo_hazardous full-select'><label class='label'>Is Cargo # " + (i+1) + " Hazardous?</label><div class='control'><div class='select full-select'><select class='full-select hazardous-select' name='is-hazardous" + (i + 1) + "'" + "><option>NO</option><option>YES</option></select></div></div></br></div></div><div class='column is-1'><br><a class='show-modal is-hazard'><i class='fas fa-info-circle guide-btn'></i></a></div></div><div class='columns hidden'><div class='column is-11'><div class='field'><label class='label'>Container # " + (i+1) + " Hazard Class</label><div class='control has-icons-left'><input class='input' name='hazard-class-" + (i + 1) + "'" + "><span class='icon is-small is-left'><i class='fas fa-exclamation-triangle'></i></span></div></div></div><div class='column is-1'><br><a class='show-modal hazard-class'><i class='fas fa-info-circle guide-btn'></i></a></div></div><div class='columns hidden'><div class='column is-11'><div class='field'><label class='label'>Container # " + (i+1) + " Un-Code</label><div class='control has-icons-left'><input class='input' name='un-code-" + (i + 1) + "'" + "><span class='icon is-small is-left'><i class='fas fa-exclamation-triangle'></i></span></div></div></div><div class='column is-1'><br><a class='show-modal un-code'><i class='fas fa-info-circle guide-btn'></i></a></div></div></div></div><br>");
	  	  container.appendChild(weight_field);
	  	}
	  } else {
	  	for (i=0; i < fields_number; i++){
	  	  var weight_field = document.createElement('div');
	  	  //for understaing the super long oneline html, copy and paste the line in https://www.freeformatter.com/html-formatter.html
	  	  weight_field.innerHTML = ("<div class='box card-shadow margin-bottom'><div class='columns'><div class='column is-11'><div class='field'><label class='label'>Container # " + (i+1) + " Gross Weight (lbs)</label><div class='control has-icons-left'><input class='input' name='weight-" + (i + 1) + "' value='" + data[i].gross_weight + "'" +"><span class='icon is-small is-left'><i class='fas fa-weight'></i></span></div></div></div><div class='column is-1'><br><a class='show-modal gross-weight'><i class='fas fa-info-circle guide-btn gross-weight'></i></a></div></div><div class='columns'><div class='column is-11'><div class='field'><label class='label'>Container # " + (i+1) + " Commercial Description</label><div class='control has-icons-left'><input class='input' name='commercial-description-" + (i + 1) + "'" + "' value='" + data[i].commercial_description + "'" + "><span class='icon is-small is-left'><i class='fas fa-weight'></i></span></div></div></div><div class='column is-1'><br><a class='show-modal commercial-description'><i class='fas fa-info-circle guide-btn'></i></a></div></div><div class='columns'><div class='column is-11'><div class='field container_type full-select'><label class='label'>Piece # " + (i+1) + " Container Type</label><div class='control'><div class='select full-select'><select class='full-select container-type-" +i+"'"+" name='container-type-" + (i + 1) + "'"  + "><option>20'</option><option>40'</option><option>40' HC</option><option>45'</option><option>45' HC</option><option>20' NOR</option><option>40' NOR</option><option>20' Flat Rack</option><option>40' Flat Rack</option><option>20' Open Top</option><option>40' Open Top</option></select></div></div></div></div><div class='column is-1'><br><a class='show-modal container-type'><i class='fas fa-info-circle guide-btn'></i></a></div></div><br><div class='columns'><div class='column is-11'><div class='field cargo_hazardous full-select'><label class='label'>Is Cargo # " + (i+1) + " Hazardous?</label><div class='control'><div class='select full-select'><select class='full-select hazardous-select cargo-hazardous-"+i +"'"+" name='is-hazardous" + (i + 1) + "'" + "><option>NO</option><option>YES</option></select></div></div></br></div></div><div class='column is-1'><br><a class='show-modal is-hazard'><i class='fas fa-info-circle guide-btn'></i></a></div></div><div class='columns hidden'><div class='column is-11'><div class='field'><label class='label'>Container # " + (i+1) + " Hazard Class</label><div class='control has-icons-left'><input class='input' name='hazard-class-" + (i + 1) + "'" + "' value='" + data[i].hazardous_class + "'" + "><span class='icon is-small is-left'><i class='fas fa-exclamation-triangle'></i></span></div></div></div><div class='column is-1'><br><a class='show-modal hazard-class'><i class='fas fa-info-circle guide-btn'></i></a></div></div><div class='columns hidden'><div class='column is-11'><div class='field'><label class='label'>Container # " + (i+1) + " Un-Code</label><div class='control has-icons-left'><input class='input' name='un-code-" + (i + 1) + "'" + "' value='" + data[i].un_code + "'" +"><span class='icon is-small is-left'><i class='fas fa-exclamation-triangle'></i></span></div></div></div><div class='column is-1'><br><a class='show-modal un-code'><i class='fas fa-info-circle guide-btn'></i></a></div></div></div></div><br>");
	  	  container.appendChild(weight_field);
	  	  $('.cargo-hazardous-'+i).val(data[i].cargo_hazardous);
	  	  $('.container-type-'+i).val(data[i].container_size);
	  	}
	  }
	  hideHazFieldsWhenSaved();
	}

	function hideHazFieldsWhenSaved(){
		if($('#container')[0] !== undefined){
		  for (i=0; i < $('#container')[0].childNodes.length; i++) {
		  	haz = $('#container')[0].children[i].children[0].children[4].children[0].children[0].children[1].children[0].children[0];
		  	if(haz.value === "YES"){
		  		hazClass = haz.parentNode.parentNode.parentNode.parentNode.parentNode.nextSibling.classList;
		  		unCode = haz.parentNode.parentNode.parentNode.parentNode.parentNode.nextSibling.nextSibling.classList;

			  	hazClass.remove("hidden");
					unCode.remove("hidden");
		  	}
		  }
		}  
	} 

	// Multiple containers generator
	$('.pieces-number-diff').on("change keydown paste input", () => {
		addFields($('.input.pieces-number-diff').val(), []);
	});

	if (container !== null ){
		$.ajax({
		  type: "POST",
		  url: "/pieces_for_cargo_info",
		  data: { fcl_exw_cargo_info_step_id: $('.fcl_exw_cargo_info_step_id').val() },
		  success: function(data){

		  	if(data[data.length-1] === 'update'){
		  		addFields($('.input.pieces-number-diff').val(), data);
		  	}else{

		  	}
			},
			error: function(data){
	  		console.log('error')
			}   
		});
	}

	$('select').onchange = function() {
    var value = $(this).children(":selected").attr("value");
	}

	function activateGuide (event) {
		classList = event.target.parentElement.classList
	  value = classList[classList.length-1];
	  if(value.includes('weight')){
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

