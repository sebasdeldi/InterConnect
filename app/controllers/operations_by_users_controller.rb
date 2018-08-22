class OperationsByUsersController < ApplicationController

	before_action :authenticate_user!, :require_new_operation_permission, :set_variables
	before_action :fetch_following_two_last_digits, only: [:create]

	def new
	end

	def create
		if is_representative?
			representative_operation_creation(fetch_following_two_last_digits)
		elsif is_agent?
			agent_operation_creation
		end
	end

	private

		def fetch_following_two_last_digits
		  if ((Operation.last.nil?) || (Operation.last.created_at < Time.current.beginning_of_day))
		    "00"
		  else
		  	ref = (Operation.last.reference.last(2).to_i + 1).to_s
		  	if ref.length == 1
		  		ref = '0' + ref
		  	end
		  end
		end

		def set_variables
			@operations_by_user = OperationsByUser.new
			@agents = current_user.relateds.where(role_id: 3)
			@shippers = current_user.relateds.where(role_id: 4)
			@representatives = User.representatives
			@consignees = User.consignees
		end

		def representative_operation_creation(last_digits)
			if params[:operations_by_user][:agent_id].present? && params[:operations_by_user][:shipper_id].present?
				date_arr = Date.today.to_s.split('-') 
				reference = (current_user.contact_first_name[0..0] + current_user.contact_last_name[0..0] + date_arr[2] + date_arr[1] + date_arr[0][2..4] + last_digits).upcase
				fields = [ reference, params[:modality], strong_params_for_representatives, current_user, params[:pieces_number], params[:po_number], params[:reference_number] ]
				new_operation = @operations_by_user.create_for_representatives(fields)
				set_notice
				redirect_to operation_path(new_operation)
			else
				set_alert
			end
		end

		def agent_operation_creation
			if params[:operations_by_user][:representative_id].present?
				@operations_by_user.create_for_agents(params[], params[:modality], strong_params_for_agents, current_user)
				set_notice
			else
				set_alert
			end
		end

		def set_notice
			flash[:notice] = "Operation successfuly created."
			cookies.permanent[:redirect_tab] = 'operations_tab'
		end

		def set_alert
			flash[:alert] = "Please choose a valid option."
			render :new
		end

		def strong_params_for_representatives
			params.require(:operations_by_user).permit(:agent_id, :shipper_id, :consignee_id)
		end

		def strong_params_for_agents
			params.require(:operations_by_user).permit(:representative_id)
		end

end
