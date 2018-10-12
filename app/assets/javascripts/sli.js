

document.addEventListener("turbolinks:load", function() {
	$('.schedule-b-amount').val(0);

	var addScheduleBFields = (fields_number, data) => {
	  var container = document.getElementById('schedule-b-container');
	  while (container.hasChildNodes()) {
	    container.removeChild(container.lastChild);
	  }
	  for (i=0; i < fields_number; i++){
	    var weight_field = document.createElement('div');
	    weight_field.innerHTML = ('<select name="code-'+ (i+1) +'"><option selected="selected" value="Domestic (D)">Domestic (D)</option><option value="Foreign (F)">Foreign (F)</option><option value="FMS (M)">FMS (M)</option></select> <input name="number-'+ (i+1) +'" id="schedule-b-number" placeholder="Schedule B Number" type="text"> <input class="quantity" name="quantity-'+ (i+1) +'" id="quantity" placeholder="Quantity/unit of measure" type="number"> <input class="weight" name="weight-'+ (i+1) +'" id="weight" placeholder="Weight (LBS)" type="number"> <input name="value-'+ (i+1) +'" id="value" placeholder="Value (USD)" type="text"> <input name="eccn-'+ (i+1) +'" id="eccn" placeholder="ECCN (if necessary)" type="text">');
	    container.appendChild(weight_field);
	  }
	} 

	// Multiple containers generator
	$('.schedule-b-amount').on("change keydown paste input", () => {
	  console.log("working");
	  addScheduleBFields($('.schedule-b-amount').val(), []);
	});
});

