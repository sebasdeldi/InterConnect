


document.addEventListener("turbolinks:load", function() {

	$(".shipper-registration").on("ajax:success", function(event) {
		onShipperSubmit(event, true);
	});

	$(".main-registration").on("ajax:success", function(event) {
		onShipperSubmit(event, false);
		$("input[type=text]").val('');
	});


	var onShipperSubmit = (event, redirect) => {

		var detail = event.detail;
		var data = detail[0], status = detail[1],  xhr = detail[2];
		if (data.success){
			swal({
			  title: "Contact registered!",
			  text: "Contact correctly registered!",
			  icon: "success",
			  button: "Close",
			});
			if(redirect){
				redirectOnSuccess();
			}
		}else{
			swal({
			  title: "Registration failed!",
			  text: "Please fill in the fields marked with '*'",
			  icon: "error",
			  button: "Close",
			});
		}
	}

	var redirectOnSuccess = () => {
		$('.input').val('');
		setTimeout(function() {
		  window.location.href = "/operations/operations_by_users/new"
		}, 2500);
	}

	/*$('.row').on('click', (e) => {
		$(".agent").on("ajax:success", function(event,) {
			onSubmit(event, 'agent');
		});

		$(".shipper").on("ajax:success", function(event) {
			onSubmit(event, 'shipper');
		});

		
		var onSubmit = (event, roleName) => {

			var detail = event.detail;
			var data = detail[0], status = detail[1],  xhr = detail[2];

			if(data.email_error == null && data.password_error == null && data.password_confirmation_error == null ){
				swal({
				  title: "User registered!",
				  text: "User registered with the expected permissions",
				  icon: "success",
				  button: "Close",
				});
				$('.input').val('');
				removeErrors(roleName);
			}else{
				if (data.email_error[0] != null) { emailError(data.email_error[0], data.role) } else { removeEmailError(data.role) }
				if (data.password_error[0] != null) { passwordError(data.password_error[0], data.role) } else { removePasswordError(data.role) }
				if (data.password_confirmation_error[0] != null) { passwordConfirmationError(data.password_confirmation_error[0], data.role) } else { removePasswordConfirmationError(data.role) }		
			}
		}


		var removeErrors = (role) => {
			console.log(role)
			removeEmailError(role);
			removePasswordError(role);
			removePasswordConfirmationError(role);
		}

		var emailError = (error, role) => {
			$('.email.'+role).addClass('is-danger');
			$('.fa-envelope.email.'+role).addClass('is-danger-icon');
			if ($('.help.email.'+role).length === 0) { $('.field.email.'+ role).append('<p class="help is-danger email ' + role + '">' + error + '</p>'); }
		}

		var passwordError = (error, role) => {
			$('.password.'+role).addClass('is-danger');
			$('.fa-lock.password.'+role).addClass('is-danger-icon');
			if ($('.help.password.'+role).length === 0) { $('.field.password.'+role).append('<p class="help is-danger password ' + role + '">'+ error + '</p>'); }
		}

		var passwordConfirmationError = (error, role) => {
			$('.password-confirmation.'+role).addClass('is-danger');
			$('.fa-lock.password-confirmation.'+role).addClass('is-danger-icon');
			if ($('.help.password-confirmation.'+role).length === 0) { $('.field.password-confirmation.'+role).append('<p class="help is-danger password-confirmation ' + role + '">'+ error + '</p>'); }
		}

		var removeEmailError = (role) => {
			$('.email.'+role).removeClass('is-danger');
			$('.fa-envelope.email.'+role).removeClass('is-danger-icon');
			$('.help.email').remove('');
		}

		var removePasswordError = (role) => {
			$('.password.'+role).removeClass('is-danger');
			$('.fa-lock.password').removeClass('is-danger-icon');
			$('.help.password').remove('');
		}

		var removePasswordConfirmationError = (role) => {
			$('.password-confirmation.'+role).removeClass('is-danger');
			$('.fa-lock.password-confirmation').removeClass('is-danger-icon');
			$('.help.password-confirmation').remove('');
		}
	});*/
});
