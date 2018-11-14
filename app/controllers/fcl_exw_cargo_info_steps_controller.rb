class FclExwCargoInfoStepsController < ApplicationController
	def new
		@fcl_cargo_info = FclExwCargoInfoStep.new
		@operation = Operation.find_by(secure_id: params[:operation_secure_id])
	end

	def create
		@fcl_cargo_info = FclExwCargoInfoStep.new
		op = Operation.find_by(secure_id: params[:operation_secure_id])
	  if FclExwCargoInfoStep.create_cargo_info(params, fcl_cargo_info_params)
	  	flash[:notice] = 'Information correctly updated'
	  	if current_user
	  		redirect_to operation_path op.id
	  	else
	  		redirect_back(fallback_location: unauthenticated_root_path)
	  	end
	  else
	  	flash[:alert] = 'Information could not be saved, please fill in all the information listed bellow'
	  	if current_user
	  		redirect_to new_fcl_exw_cargo_info_step_path(operation_id: op.id)
	  	else
	  		redirect_back(fallback_location: unauthenticated_root_path)
	  	end
	  end
	end

	private
		def fcl_cargo_info_params
			params.require(:fcl_exw_cargo_info_step).permit({files: []}, :operation_id, :loading_address, :loading_date, :loading_time, :gross_weight, :commercial_description, :cargo_hazardous, :hazardous_document, :pickup_reference, :contact_name, :contact_email, :contact_number, :contact_company, :pieces_number, :bonded, :self_propelled)
		end

end

