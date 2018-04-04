class FclExwCargoInfosController < ApplicationController
	def new
		@fcl_cargo_info = FclExwCargoInfo.new
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
				flash[:notice] = 'Information correctly saved'
				redirect_to operation_path params[:operation_id]
			else
				flash[:alert] = 'Information could not be saved, please fill in all the information listed bellow'
				redirect_to new_fcl_exw_cargo_info_path(operation_id: params[:operation_id])
			end
		end

	end

	private

		def existing_fcl_cargo_info (operation_id)
		  FclExwCargoInfo.find_by(operation_id: operation_id)
		end

		def fcl_cargo_info_params
			params.require(:fcl_exw_cargo_info).permit(:operation_id, :loading_address, :container_size, :loading_datetime, :gross_weight, :commercial_description, :cargo_hazardous, :hazardous_document,
			 :schedule_b_number, :schedule_b_number, :ein, :pickup_reference, :contact_name, :contact_email, :contact_phone, :contact_company)
		end
end

