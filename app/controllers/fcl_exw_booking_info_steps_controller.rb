class FclExwBookingInfoStepsController < ApplicationController
  def new
  	@fcl_booking_info = FclExwBookingInfoStep.new
  	@existing_fcl_booking_info = existing_fcl_booking_info(Operation.find_by(secure_id: params[:operation_secure_id]).id)
  end

  def create
		@fcl_booking_info = FclExwBookingInfoStep.new
		existing_booking_info = existing_fcl_booking_info(Operation.find_by(secure_id: params[:operation_secure_id]).id)


		if (params[:fcl_exw_booking_info_step][:doc_cut_off_date].present?)
			if existing_booking_info.doc_cut_off_date.nil?
				Task.create(note: 'Document cut off date set.' , due_date: params[:fcl_exw_booking_info_step][:doc_cut_off_date], fcl_exw_booking_info_steps_id: existing_booking_info.id, operation_id: Operation.find_by(secure_id: params[:operation_secure_id]).id, subject: 'doc_cut_off' )
			else
				Task.where(subject: 'doc_cut_off', fcl_exw_booking_info_steps_id: existing_booking_info.id).first.update(due_date: params[:fcl_exw_booking_info_step][:doc_cut_off_date], status: '0')
			end
		end

		if (params[:fcl_exw_booking_info_step][:cargo_cut_off_date].present?)
			if existing_booking_info.cargo_cut_off_date.nil?
				Task.create(note: 'Cargo cut off date set.', due_date: params[:fcl_exw_booking_info_step][:cargo_cut_off_date], fcl_exw_booking_info_steps_id: existing_booking_info.id, operation_id: Operation.find_by(secure_id: params[:operation_secure_id]).id, subject: 'cargo_cut_off' )
			else
				Task.where(subject: 'cargo_cut_off', fcl_exw_booking_info_steps_id: existing_booking_info.id).first.update(due_date: params[:fcl_exw_booking_info_step][:cargo_cut_off_date], status: '0')
			end

		end

		if (params[:fcl_exw_booking_info_step][:sailing_date].present?)
			if existing_booking_info.sailing_date.nil?
				Task.create(note: 'Expected sailing date set.', due_date: params[:fcl_exw_booking_info_step][:sailing_date], fcl_exw_booking_info_steps_id: existing_booking_info.id, operation_id: Operation.find_by(secure_id: params[:operation_secure_id]).id, subject: 'sailing_date' )
			else
				Task.where(subject: 'sailing_date', fcl_exw_booking_info_steps_id: existing_booking_info.id).first.update(due_date: params[:fcl_exw_booking_info_step][:sailing_date], status: '0')
			end
		end

		if (params[:fcl_exw_booking_info_step][:arrival_date].present?)
			if existing_booking_info.arrival_date.nil?
				Task.create(note: 'Expected arrival date set.', due_date: params[:fcl_exw_booking_info_step][:arrival_date], fcl_exw_booking_info_steps_id: existing_booking_info.id, operation_id: Operation.find_by(secure_id: params[:operation_secure_id]).id, subject: 'arrival_date' )
			else
				Task.where(subject: 'arrival_date', fcl_exw_booking_info_steps_id: existing_booking_info.id).first.update(due_date: params[:fcl_exw_booking_info_step][:arrival_date], status: '0')
			end
		end

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
