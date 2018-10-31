class FclExwCargoInfoStepsController < ApplicationController
	def new
		@fcl_cargo_info = FclExwCargoInfoStep.new
		@operation = Operation.find_by(secure_id: params[:operation_secure_id])
		@existing_fcl_cargo_info = existing_fcl_cargo_info(@operation.id)
		@ein = OperationsByUser.find_by(operation_id: @operation.id).shipper.ein
	end

	def create
		@fcl_cargo_info = FclExwCargoInfoStep.new
		existing_cargo_info = existing_fcl_cargo_info(Operation.find_by(secure_id: params[:operation_secure_id]).id)
	  if existing_cargo_info.update(fcl_cargo_info_params.merge(operation_id: Operation.find_by(secure_id: params[:operation_secure_id]).id))
	  	op = Operation.find_by(secure_id: params[:operation_secure_id])
			op.update(fcl_exw_quotation_confirmed: true, status: 'IN PROGRESS', current_step: 4, status_message: 'Request Booking Order')
			existing_bonded = Task.where(operation_id: op.id, subject: 'bonded_doc').first
			existing_self_propelled = Task.where(operation_id: op.id, subject: 'self_propelled_doc').first

			if params[:fcl_exw_cargo_info_step][:bonded] == 'true'
				if existing_bonded.nil?
					Task.create(operation_id: op.id, note: 'Verify bonded docummentation', due_date: Time.now + 1.weeks , subject:'bonded_doc')				
				else
					existing_bonded.update(status: '0')
				end
			else
				if !existing_bonded.nil?
					existing_bonded.update(status: '1')
				end
			end

			if params[:fcl_exw_cargo_info_step][:self_propelled] == 'true'
				if existing_self_propelled.nil?
					Task.create(operation_id: op.id, note: "Send self propelled docummentation (tittle/bill of sells original & notarized, power of attorney, copy of power of attorney signer's id) to broker", due_date: Time.now + 1.weeks , subject:'self_propelled_doc')				
				else
					existing_self_propelled.update(status: '0')
				end
			else
				if !existing_self_propelled.nil?
					existing_self_propelled.update(status: '1')
				end
			end

			Task.create(note: "Please verify that your POD, POL, container size, loading address and hazmat status match the operation's quotation. Also be aware of any overweight extra fee (20' bellow 35.000lbs, 40' and 45' bellow 42.000)", due_date: Time.now + 4.days, operation_id: op.id, subject: 'quotation_review' )

			shipper = OperationsByUser.find_by(operation_id: op.id).shipper
			if shipper.ein != params[:fcl_exw_cargo_info_step][:ein]
				shipper.update!(ein: params[:fcl_exw_cargo_info_step][:ein])
			end
			#Creating easy to loop params array
			params_array = params.to_unsafe_h.to_a
			create_pieces(params_array, existing_cargo_info)
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

	def request_info
		shipper = User.find(params[:shipper_id])
		agent = User.find(params[:agent_id])
		op = Operation.find(params[:operation_id])
		FclExwOperationMailer.info_request(shipper, current_user, agent, op.secure_id).deliver_later
		if op.update(status: 'IN PROGRESS', status_message:'Confirm Cargo Info Received', current_step: 2)
			FclExwInfoRequestedStep.find_by(operation_id: params[:operation_id]).update(completed: true)
			flash[:notice] = "An email sent to shipper:" + shipper.email + " from " + shipper.company_name
			redirect_to operation_path params[:operation_id]
		end
	end

	def confirm_info
		if Operation.find(params[:operation_id]).update(fcl_exw_info_confirmed: true, status: 'IN PROGRESS' ,status_message: 'Upload Cargo Info To System', current_step: 3)
			FclExwInfoConfirmedStep.find_by(operation_id: params[:operation_id]).update(completed: true)
			flash[:notice] = "Step confirmed, no more reminders will be sent"
			redirect_to operation_path params[:operation_id]
		end
	end

	def confirm_loading
		shipper = User.find(params[:shipper_id])
		agent = User.find(params[:agent_id])
		op = Operation.find(params[:operation_id])
		if Operation.find(params[:operation_id]).update(status: 'IN PROGRESS' ,status_message: 'Confirm Container Delivery', current_step: 7)
			FclExwContainerLoading.find_by(operation_id: params[:operation_id]).update(completed: true)
			FclExwOperationMailer.container_loading(agent, op, shipper, current_user).deliver_later
			flash[:notice] = "Step confirmed"
			redirect_to operation_path params[:operation_id]
		end
	end

	def confirm_delivery
		shipper = User.find(params[:shipper_id])
		agent = User.find(params[:agent_id])
		op = Operation.find(params[:operation_id])
		if Operation.find(params[:operation_id]).update(status: 'COMPLETED' ,status_message: 'Completed', current_step: 8)
			FclExwContainerDelivery.find_by(operation_id: params[:operation_id]).update(completed: true)
			FclExwOperationMailer.container_delivery(agent, op, shipper, current_user).deliver_later
			flash[:notice] = "Step confirmed"
			redirect_to operation_path params[:operation_id]
		end
	end

	def confirm_quotation
		shipper = User.find(params[:shipper_id])
		agent = User.find(params[:agent_id])
		op = Operation.find(params[:operation_id])
		operation =  Operation.find(params[:operation_id])
		if params[:commit] == 'ISSUE'
			shipper = User.find(params[:shipper_id])
			agent = User.find(params[:agent_id])
			FclExwOperationMailer.issue_quotation(shipper, current_user, agent, operation).deliver_later
		else
			if operation.update(fcl_exw_quotation_confirmed: true, status: 'IN PROGRESS', status_message:'Request Cargo Info To Shipper', current_step: 1)
				FclExwQuotationConfirmedStep.find_by(operation_id: params[:operation_id]).update(completed: true, files: params[:files])
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
		FclExwOperationMailer.request_booking(shipper, operation, carrier, additional_message, current_user).deliver_later
		FclExwOperationMailer.request_booking_notification(agent, step, carrier, current_user).deliver_later
		if op.update(status: 'IN PROGRESS', status_message:'Booking order sent to ', current_step: 5, status_message:'Fill In Booking Info')
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
			params.require(:fcl_exw_cargo_info_step).permit({files: []}, :operation_id, :loading_address, :loading_date, :loading_time, :gross_weight, :commercial_description, :cargo_hazardous, :hazardous_document, :pickup_reference, :contact_name, :contact_email, :contact_number, :contact_company, :pieces_number, :bonded, :self_propelled)
		end

	  def create_pieces (params_array, cargo_info)
	  	Piece.where(fcl_exw_cargo_info_step_id: cargo_info.id).delete_all
	  	params_array = params_array.drop(4)[0..-4]
      (0..params_array.length).step(6) do |element|
      	unless params_array[element].nil?
        	piece = Piece.create(fcl_exw_cargo_info_step_id: cargo_info.id, gross_weight: params_array[element][1], commercial_description: params_array[element+1][1], container_size: params_array[element+2][1], cargo_hazardous: params_array[element+3][1], hazardous_class: params_array[element+4][1], un_code: params_array[element+5][1] )
      	end
      end
    end
end

