
var ready = () => {

	$("#new_user").on("ajax:success", function(event) {
		var detail = event.detail;
		var data = detail[0], status = detail[1],  xhr = detail[2];

		if(data.email_error == null && data.password_error == null && data.password_confirmation_error == null ){
			removeEmailError();
			removePasswordError();
			removePasswordConfirmationError();
			swal({
			  title: "User registered!",
			  text: "User registered with agent permissions",
			  icon: "success",
			  button: "Close",
			});
		}else{
			if (data.email_error[0] != null) { emailError(data.email_error[0]) } else { removeEmailError() }
			if (data.password_error[0] != null) { passwordError(data.password_error[0]) } else { removePasswordError() }
			if (data.password_confirmation_error[0] != null) { passwordConfirmationError(data.password_confirmation_error[0]) } else { removePasswordConfirmationError() }		
		}
		console.log(data)

	});

	var emailError = (error) => {
		$('#user_email').addClass('is-danger');
		$('.fa-envelope.email').addClass('is-danger-icon');
		if ($('.help.email').length === 0) { $('.field.email').append('<p class="help is-danger email">' + error + '</p>'); }
	}

	var passwordError = (error) => {
		$('#user_password').addClass('is-danger');
		$('.fa-lock.password').addClass('is-danger-icon');
		if ($('.help.password').length === 0) { $('.field.password').append('<p class="help is-danger password">' + error + '</p>'); }
	}

	var passwordConfirmationError = (error) => {
		$('#user_password_confirmation').addClass('is-danger');
		$('.fa-lock.password-confirmation').addClass('is-danger-icon');
		if ($('.help.password-confirmation').length === 0) { $('.field.password-confirmation').append('<p class="help is-danger password-confirmation">' + error + '</p>'); }
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
$(document).on("page:load", ready);