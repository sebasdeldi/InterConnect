class FclExwBookingInfoStepsController < ApplicationController
  def new
  	@fcl_booking_info = FclExwBookingInfoStep.new
  	@existing_fcl_booking_info = existing_fcl_booking_info(Operation.find_by(secure_id: params[:operation_secure_id]).id)
  end

  def create
		@fcl_booking_info = FclExwBookingInfoStep.new
		existing_booking_info = existing_fcl_booking_info(Operation.find_by(secure_id: params[:operation_secure_id]).id)
	  if existing_booking_info.update(fcl_booking_info_params.merge(operation_id: Operation.find_by(secure_id: params[:operation_secure_id]).id))
	  	op = Operation.find_by(secure_id: params[:operation_secure_id])
			op.update(fcl_exw_quotation_confirmed: true, status: 'COMPLETED', current_step: 6, status_message: 'Job Done!')
			agent = OperationsByUser.find_by(operation_id: op.id).agent
			FclExwOperationMailer.booking_info(agent, current_user, existing_booking_info).deliver_later
			flash[:notice] = 'Information correctly updated'
			redirect_to operation_path op.id
		else
			flash[:alert] = 'Information could not be saved, please fill in all the information listed bellow'
			redirect_to new_fcl_exw_cargo_info_step_path(operation_id: op.id)
		end
  end

	private

		def existing_fcl_booking_info (operation_id)
		  FclExwBookingInfoStep.find_by(operation_id: operation_id)
		end

		def fcl_booking_info_params
			params.require(:fcl_exw_booking_info_step).permit(:operation_id, :booking_number, :vessel, :voyage, :doc_cut_off_date, :doc_cut_off_time, 
				:cargo_cut_off_date, :cargo_cut_off_time, :sailing_date, :sailing_time, :arrival_date, :arrival_time)
		end
end
