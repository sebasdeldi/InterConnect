
// GENERAL INFO FORM CHOOSING LOGIC


var ready = () => {

	$(".form-button").on("click", (e) => {
		var formName = (e.currentTarget.attributes[1].nodeValue);
		hideAll();
	  $("#" + formName).removeClass("hidden");
	  $("#" + formName).addClass("unhidden");
	});

	var hideAll = () => {
	  $("#different-info").addClass("hidden");
	  $("#grouped-info").addClass("hidden");
	  $("#type-info").addClass("hidden");
	}

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
	    weight_field.innerHTML = ("<div class='box card-shadow'><div class='field'><label class='label'>Piece # " + (i+1) + " Weight (pounds)</label><div class='control has-icons-left'><input class='input' name='weight-" + (i + 1) + "'" + "><span class='icon is-small is-left'><i class='fas fa-envelope email'></i></span></div></div><div class='field'><label class='label'>Piece # " + (i+1) + " Height (inches)</label><div class='control has-icons-left'><input class='input' name='height-" + (i + 1) + "'" +  "><span class='icon is-small is-left'><i class='fas fa-envelope email'></i></span></div></div><div class='field'><label class='label'>Piece # " + (i+1) + " Depth (inches)</label><div class='control has-icons-left'><input class='input' name='depth-" + (i + 1) + "'" +  "><span class='icon is-small is-left'><i class='fas fa-envelope email'></i></span></div></div><div class='field'><label class='label'>Piece # " + (i+1) + " Width (inches)</label><div class='control has-icons-left'><input class='input' name='width-" + (i + 1) + "'" +  "><span class='icon is-small is-left'><i class='fas fa-envelope email'></i></span></div></div><div class='field piece_type'><label class='label'>Piece # " + (i+1) + " Type</label><div class='control'><div class='select'><select name='piece-type-" + (i + 1) + "'" + "><option>Box</option><option>Pallet</option></select></div></div></div></div><br>");
	    container.appendChild(weight_field);
	  }
	}

	$("#different-info-form").on("ajax:success", function(event) {
		var detail = event.detail;
		var data = detail[0];

		if(data.tax_id_error == null && data.packing_list_error == null && data.pv_address_error == null && data.invoice_error == null && data.pieces_number_error == null ){
			removeErrors();
			swal({
			  title: "Info loaded!",
			  text: "Cargo information succesfully loaded to the system",
			  icon: "success",
			  button: "Close",
			});
		}else{
			if (data.tax_id_error[0] != null) { taxIdError(data.tax_id_error[0]) } else { removeTaxIdError() }
			if (data.packing_list_error[0] != null) { packingListError(data.packing_list_error[0]) } else { removePackingListError() }
			if (data.pv_address_error[0] != null) { pvAddressError(data.pv_address_error[0]) } else { removePvAddressError() }		
			if (data.invoice_error[0] != null) { invoiceError(data.invoice_error[0]) } else { removeInvoiceError() }		
			if (data.pieces_number_error[0] != null) { piecesNumberError(data.pieces_number_error[0]) } else { removePiecesNumberError() }		
		}
	});

	var removeErrors = () => {
		removeTaxIdError();
		removePackingListError();
		removePvAddressError();
		removeInvoiceError();
		removePiecesNumberError();
	}

	var piecesNumberError = (error) => {
		$('.pieces-number-diff').addClass('is-danger');
		$('.fa-envelope.pieces-number-diff').addClass('is-danger-icon');
		if ($('.help.pieces-number-diff').length === 0) { $('.field.pieces-number-diff').append('<p class="help is-danger pieces-number-diff">' + error + '</p>'); }
	}

	var taxIdError = (error) => {
		$('.tax-id').addClass('is-danger');
		$('.fa-envelope.tax-id').addClass('is-danger-icon');
		if ($('.help.tax-id').length === 0) { $('.field.tax-id').append('<p class="help is-danger tax-id">' + error + '</p>'); }
	}

	var packingListError = (error) => {
		$('.packing-list').addClass('is-danger');
		$('.fa-envelope.packing-list').addClass('is-danger-icon');
		if ($('.help.packing-list').length === 0) { $('.field.packing-list').append('<p class="help is-danger packing-list">' + error + '</p>'); }
	}

	var pvAddressError = (error) => {
		$('.pv-address').addClass('is-danger');
		$('.fa-envelope.pv-address').addClass('is-danger-icon');
		if ($('.help.pv-address').length === 0) { $('.field.pv-address').append('<p class="help is-danger pv-address">' + error + '</p>'); }
	}

	var invoiceError = (error) => {
		$('.invoice').addClass('is-danger');
		$('.fa-envelope.invoice').addClass('is-danger-icon');
		if ($('.help.invoice').length === 0) { $('.field.invoice').append('<p class="help is-danger invoice">' + error + '</p>'); }
	}

	var removeTaxIdError = () => {
		$('.tax-id').removeClass('is-danger');
		$('.fa-envelope.tax-id').removeClass('is-danger-icon');
		$('.help.tax-id').remove('');
	}

	var removePackingListError = () => {
		$('.packing-list').removeClass('is-danger');
		$('.fa-envelope.packing-list').removeClass('is-danger-icon');
		$('.help.packing-list').remove('');
	}

	var removePvAddressError = () => {
		$('.pv-address').removeClass('is-danger');
		$('.fa-envelope.pv-address').removeClass('is-danger-icon');
		$('.help.pv-address').remove('');
	}

	var removeInvoiceError = () => {
		$('.invoice').removeClass('is-danger');
		$('.fa-envelope.invoice').removeClass('is-danger-icon');
		$('.help.invoice').remove('');
	}

	var removePiecesNumberError = () => {
		$('.pieces-number-diff').removeClass('is-danger');
		$('.fa-envelope.pieces-number-diff').removeClass('is-danger-icon');
		$('.help.pieces-number-diff').remove('');
	}

}

$(document).ready(ready);
$(document).on('page:load', ready);
