
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

	$('#different-info-input').on("change keydown paste input", () => {
		addFields($('#different-info-input').val())
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
		console.log(event.data)

		if(data.email_error == null && data.password_error == null && data.password_confirmation_error == null ){
			removeEmailError();
			removePasswordError();
			removePasswordConfirmationError();
			swal({
			  title: "Info loaded!",
			  text: "Cargo information succesfully loaded to the system",
			  icon: "success",
			  button: "Close",
			});
		}else{
			if (data.email_error[0] != null) { emailError(data.email_error[0]) } else { removeEmailError() }
			if (data.password_error[0] != null) { passwordError(data.password_error[0]) } else { removePasswordError() }
			if (data.password_confirmation_error[0] != null) { passwordConfirmationError(data.password_confirmation_error[0]) } else { removePasswordConfirmationError() }		
		}
	});


	var piecesNumberError = (error) => {
		$('#different-info-input').addClass('is-danger');
		$('.fa-envelope.pieces_number').addClass('is-danger-icon');
		if ($('.help.pieces_number').length === 0) { $('.field.pieces_number').append('<p class="help is-danger pieces_number">' + error + '</p>'); }
	}

	var piecesNumberError = (error) => {
		$('#different-info-input').addClass('is-danger');
		$('.fa-envelope.email').addClass('is-danger-icon');
		if ($('.help.email').length === 0) { $('.field.email').append('<p class="help is-danger email">' + error + '</p>'); }
	}

	var piecesNumberError = (error) => {
		$('#different-info-input').addClass('is-danger');
		$('.fa-envelope.email').addClass('is-danger-icon');
		if ($('.help.email').length === 0) { $('.field.email').append('<p class="help is-danger email">' + error + '</p>'); }
	}

	var piecesNumberError = (error) => {
		$('#different-info-input').addClass('is-danger');
		$('.fa-envelope.email').addClass('is-danger-icon');
		if ($('.help.email').length === 0) { $('.field.email').append('<p class="help is-danger email">' + error + '</p>'); }
	}

	var piecesNumberError = (error) => {
		$('#different-info-input').addClass('is-danger');
		$('.fa-envelope.email').addClass('is-danger-icon');
		if ($('.help.email').length === 0) { $('.field.email').append('<p class="help is-danger email">' + error + '</p>'); }
	}

	var piecesNumberError = (error) => {
		$('#different-info-input').addClass('is-danger');
		$('.fa-envelope.email').addClass('is-danger-icon');
		if ($('.help.email').length === 0) { $('.field.email').append('<p class="help is-danger email">' + error + '</p>'); }
	}

	

	

	var removeEmailError = () => {
		$('#user_email').text('');
		$('#user_email').removeClass('is-danger');
		$('.fa-envelope.email').removeClass('is-danger-icon');
		$('.help.email').remove('');
	}

	var removePasswordError = () => {
		$('#user_password').text('');
		$('#user_password').removeClass('is-danger');
		$('.fa-lock.password').removeClass('is-danger-icon');
		$('.help.password').remove('');
	}

	var removePasswordConfirmationError = () => {
		$('#user_password_confirmation').text('');		
		$('#user_password_confirmation').removeClass('is-danger');
		$('.fa-lock.password-confirmation').removeClass('is-danger-icon');
		$('.help.password-confirmation').remove('');
	}

}

$(document).ready(ready);
$(document).on('page:load', ready);
