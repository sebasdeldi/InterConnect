
// TABS LOGIC

document.addEventListener("turbolinks:load", function() {

	if(($('.doc_hour')[0] == undefined) || ($('.doc_mins')[0] == undefined) || ($('.cargo_hour')[0] == undefined) || ($('.cargo_mins')[0] == undefined) || ($('.sailing_hour')[0] == undefined)|| ($('.sailing_mins')[0] == undefined) || ($('.arrival_hour')[0] == undefined)|| ($('.arrival_mins')[0] == undefined)){
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
});
