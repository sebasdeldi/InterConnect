class FclExwCargoInfosController < ApplicationController
	def new
		@fcl_cargo_info = FclExwCargoInfo.new
		@existing_fcl_cargo_info = existing_fcl_cargo_info(params[:operation_id])
	end

	def create
		@fcl_cargo_info = FclExwCargoInfo.new
		if !existing_fcl_cargo_info(params[:operation_id]).nil?
		  if existing_fcl_cargo_info(params[:operation_id]).update(fcl_cargo_info_params.merge(operation_id: params[:operation_id]))
				flash[:notice] = 'Information correctly updated'
				redirect_to operation_path params[:operation_id]
			else
				flash[:alert] = 'Information could not be updated, please fill in all the information listed bellow'
				redirect_to new_fcl_exw_cargo_info_path(operation_id: params[:operation_id])
			end
		else
			fcl_cargo_info = FclExwCargoInfo.new(fcl_cargo_info_params.merge(operation_id: params[:operation_id]))
			if fcl_cargo_info.save
				Operation.find(params[:operation_id]).update(fcl_exw_quotation_confirmed: true, status: 'Completed: Booking order uploaded to Magaya', current_step: 4)
				flash[:notice] = 'Information correctly saved'
				redirect_to operation_path params[:operation_id]
			else
				flash[:alert] = 'Information could not be saved, please fill in all the information listed bellow'
				redirect_to new_fcl_exw_cargo_info_path(operation_id: params[:operation_id])
			end
		end

	end

	def request_info
		shipper = User.find(params[:shipper_id])
		agent = User.find(params[:agent_id])
		FclExwOperationMailer.info_request(shipper, current_user, agent).deliver_later
		if Operation.find(params[:operation_id]).update(fcl_exw_info_requested: true, status: 'In Progress: Cargo info requested to shipper', current_step: 2)
			flash[:notice] = "An email sent to shipper:" + shipper.email + " from " + shipper.company_name
			redirect_to operation_path params[:operation_id]
		end
	end

	def confirm_info
		if Operation.find(params[:operation_id]).update(fcl_exw_info_confirmed: true, status: 'In Progress: Cargo info confirmed by shipper', current_step: 3)
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
			if Operation.find(params[:operation_id]).update(fcl_exw_quotation_confirmed: true, status: 'In Progress: Quotation confirmed by agent', current_step: 1)
				flash[:notice] = "Step confirmed, no more reminders will be sent"
			end
		end
		redirect_to operation_path params[:operation_id]
	end

	private

		def existing_fcl_cargo_info (operation_id)
		  FclExwCargoInfo.find_by(operation_id: operation_id)
		end

		def fcl_cargo_info_params
			params.require(:fcl_exw_cargo_info).permit(:operation_id, :loading_address, :container_size, :loading_date, :loading_time, :gross_weight, :commercial_description, :cargo_hazardous, :hazardous_document,
			 :schedule_b_number, :schedule_b_number, :ein, :pickup_reference, :contact_name, :contact_email, :contact_phone, :contact_company)
		end
end

