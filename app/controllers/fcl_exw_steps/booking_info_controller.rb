module FclExwSteps
	class BookingInfoController < ApplicationController
	  def new
	  	@fcl_booking_info = FclExwSteps::BookingInfo.new
	  	@operation = Operation.find_by(secure_id: params[:operation_secure_id])
	  end

	  def create
			operation = Operation.find_by(secure_id: params[:operation_secure_id])
			cargo_info = FclExwSteps::CargoInfo.find_by(operation_id: operation.id)
			FclExwSteps::BookingInfo.create_pieces(params, cargo_info)
			FclExwSteps::BookingInfo.create_tasks(params)

			if FclExwSteps::BookingInfo.save_record(fcl_booking_info_params, operation, current_user)
				flash[:notice] = 'Information correctly updated'
				redirect_to operation_path operation.id
			else
				flash[:alert] = 'Information could not be saved, please fill in all the information listed bellow'
				redirect_to new_fcl_exw_steps_cargo_info_path(operation_id: operation.id)
			end
	  end

		private	
			def fcl_booking_info_params
				params.require(:fcl_exw_steps_booking_info).permit(:operation_id, :vgm_cut_off_date, :booking_number, :vessel, :voyage, :doc_cut_off_date, :doc_cut_off_time, 
					:cargo_cut_off_date, :cargo_cut_off_time, :sailing_date, :arrival_date, :ramp, :ramp_cut_off_date)
			end
	end
end