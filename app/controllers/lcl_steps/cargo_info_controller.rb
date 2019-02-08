class LclSteps::CargoInfoController < ApplicationController
	def new
		@lcl_cargo_info = LclSteps::CargoInfo.new
		@operation = Operation.find_by(secure_id: params[:operation_secure_id])
	end

	def create
		@lcl_cargo_info = LclSteps::CargoInfo.new
		op = Operation.find_by(secure_id: params[:operation_secure_id])
	  if LclSteps::CargoInfo.create_cargo_info(params, lcl_cargo_info_params)
	  	flash[:notice] = 'Information correctly updated'
	  	if current_user
	  		redirect_to operation_path op.id
	  	else
	  		redirect_back(fallback_location: unauthenticated_root_path)
	  	end
	  else
	  	flash[:alert] = 'Information could not be saved, please fill in all the information listed bellow'
	  	if current_user
	  		redirect_to new_lcl_exw_steps_cargo_info_step_path(operation_id: op.id)
	  	else
	  		redirect_back(fallback_location: unauthenticated_root_path)
	  	end
	  end
	end

	private
		def lcl_cargo_info_params
			params.require(:lcl_steps_cargo_info).permit({files: []}, :operation_id, :pickup_address, :pickup_date, :docking_hours, :gross_weight, :commercial_description, :cargo_hazardous, :hazardous_document, :pickup_reference, :contact_name, :contact_email, :contact_number, :contact_company, :pieces_number, :bonded, :self_propelled)
		end
end
