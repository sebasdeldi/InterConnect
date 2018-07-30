class FclExwCargoInfoStepsController < ApplicationController
	def new
		@fcl_cargo_info = FclExwCargoInfoStep.new
		@existing_fcl_cargo_info = existing_fcl_cargo_info(params[:operation_id])
	end

	def create
		@fcl_cargo_info = FclExwCargoInfoStep.new
	  if existing_fcl_cargo_info(params[:operation_id]).update(fcl_cargo_info_params.merge(operation_id: params[:operation_id]))
			Operation.find(params[:operation_id]).update(fcl_exw_quotation_confirmed: true, status: 'IN PROGRESS', current_step: 4, status_message: 'Request booking order')
			flash[:notice] = 'Information correctly updated'
			redirect_to operation_path params[:operation_id]
		else
			flash[:alert] = 'Information could not be updated, please fill in all the information listed bellow'
			redirect_to new_fcl_exw_cargo_info_step_path(operation_id: params[:operation_id])
		end
	end

	def request_info
		shipper = User.find(params[:shipper_id])
		agent = User.find(params[:agent_id])
		FclExwOperationMailer.info_request(shipper, current_user, agent).deliver_later
		if Operation.find(params[:operation_id]).update(status: 'IN PROGRESS', status_message:'Confirm cargo info received', current_step: 2)
			FclExwInfoRequestedStep.find_by(operation_id: params[:operation_id]).update(completed: true)
			flash[:notice] = "An email sent to shipper:" + shipper.email + " from " + shipper.company_name
			redirect_to operation_path params[:operation_id]
		end
	end

	def confirm_info
		if Operation.find(params[:operation_id]).update(fcl_exw_info_confirmed: true, status: 'IN PROGRESS' ,status_message: 'Upload cargo info to system', current_step: 3)
			FclExwInfoConfirmedStep.find_by(operation_id: params[:operation_id]).update(completed: true)
			flash[:notice] = "Step confirmed, no more reminders will be sent"
			redirect_to operation_path params[:operation_id]
		end
	end

	def confirm_quotation
		if params[:commit] == 'ISSUE'
			shipper = User.find(params[:shipper_id])
			agent = User.find(params[:agent_id])
			FclExwOperationMailer.issue_quotation(shipper, current_user, agent).deliver_later
		else
			if Operation.find(params[:operation_id]).update(fcl_exw_quotation_confirmed: true, status: 'IN PROGRESS', status_message:'Request cargo info to shipper', current_step: 1)
				FclExwQuotationConfirmedStep.find_by(operation_id: params[:operation_id]).update(completed: true)
				flash[:notice] = "Step confirmed, no more reminders will be sent"
			end
		end
		redirect_to operation_path params[:operation_id]
	end

	def request_booking
		shipper = User.find(params[:shipper_id])
		op = Operation.find(params[:operation_id])
		step = FclExwCargoInfoStep.find_by(operation_id: params[:operation_id])
		agent = User.find(params[:agent_id])
		operation = [op, step]
		carrier = User.find(params[:carrier_id])
		additional_message = params[:additional_message]

		FclExwOperationMailer.request_booking(shipper, operation, carrier, additional_message).deliver_later
		FclExwOperationMailer.request_booking_notification(agent, step, carrier).deliver_later

		if op.update(status: 'COMPLETED', status_message:'Booking order sent to ', current_step: 5, status_message:'Completed')
			FclExwRequestBookingStep.find_by(operation_id: params[:operation_id]).update(completed: true, additional_message: params[:additional_message], carrier_id: params[:carrier_id])
			flash[:notice] = "An email sent to the shipping company:" + shipper.email + " from " + shipper.company_name
			redirect_to operation_path params[:operation_id]
		end
	end

	private

		def existing_fcl_cargo_info (operation_id)
		  FclExwCargoInfoStep.find_by(operation_id: operation_id)
		end

		def fcl_cargo_info_params
			params.require(:fcl_exw_cargo_info_step).permit(:operation_id, :loading_address, :container_size, :loading_date, :loading_time, :gross_weight, :commercial_description, :cargo_hazardous, :hazardous_document,
			 :schedule_b_number, :schedule_b_number, :ein, :pickup_reference, :contact_name, :contact_email, :contact_phone, :contact_company, :pol, :pod)
		end
end

