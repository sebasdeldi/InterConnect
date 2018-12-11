class FclExwBookingInfoStep < ApplicationRecord
	strip_attributes
	belongs_to :operation
	has_many :tasks, dependent: :destroy

	def self.create_pieces (params, cargo_info)
  	Piece.where(fcl_exw_cargo_info_step_id: cargo_info.id).delete_all
  	params_array = params.to_unsafe_h.to_a.drop(4)[0..-4]
    (0..params_array.length).step(9) do |element|
    	unless params_array[element].nil?
      	piece = Piece.create!(fcl_exw_cargo_info_step_id: cargo_info.id, gross_weight: params_array[element][1], commercial_description: params_array[element+1][1], container_size: params_array[element+2][1], cargo_hazardous: params_array[element+3][1], hazardous_class: params_array[element+4][1], un_code: params_array[element+5][1], container_number: params_array[element+6][1], seal_number: params_array[element+7][1], tare_weight: params_array[element+8][1] )
    	end
    end
  end

  def self.create_tasks(params)
  	existing_booking_info = existing_fcl_booking_info(Operation.find_by(secure_id: params[:operation_secure_id]).id)
    create_doc_cut_off_tasks(params, existing_booking_info)
    create_cargo_cut_off_tasks(params, existing_booking_info)
    create_vgm_cut_off_tasks(params, existing_booking_info)
    create_sailing_date_tasks(params, existing_booking_info)
    create_arrival_date_tasks(params, existing_booking_info)
    create_ramp_cut_off_tasks(params, existing_booking_info)
  end

  def self.save_record(fcl_booking_info_params, operation, current_user)
  	existing_booking_info = existing_fcl_booking_info(operation.id)
	  if existing_booking_info.update!(fcl_booking_info_params.merge(operation_id: operation.id))
			operation.update!(fcl_exw_quotation_confirmed: true, status: 'IN PROGRESS', current_step: 7, status_message: 'Confirm Container Loading')
			agent = OperationsByUser.find_by(operation_id: operation.id).agent
			FclExwOperationMailer.booking_info(agent, current_user, existing_booking_info).deliver_later
      FclExwOperationMailer.transfer_documents(operation, current_user).deliver_later
			true
		else
			false
		end
  end

	def self.existing_fcl_booking_info (operation_id)
	  FclExwBookingInfoStep.find_by(operation_id: operation_id)
	end

  private
    def self.create_doc_cut_off_tasks(params, existing_booking_info)
      if (params[:fcl_exw_booking_info_step][:doc_cut_off_date].present?)
        if existing_booking_info.doc_cut_off_date.nil?
          Task.create!(note: 'Document cut off date set.' , due_date: params[:fcl_exw_booking_info_step][:doc_cut_off_date], fcl_exw_booking_info_steps_id: existing_booking_info.id, operation_id: Operation.find_by(secure_id: params[:operation_secure_id]).id, subject: 'Documments Cut Off Date' )
        else
          Task.where(subject: 'Documments Cut Off Date', fcl_exw_booking_info_steps_id: existing_booking_info.id).first.update!(due_date: params[:fcl_exw_booking_info_step][:doc_cut_off_date], status: '0')
        end
      end
    end

    def self.create_cargo_cut_off_tasks(params, existing_booking_info)
      if (params[:fcl_exw_booking_info_step][:cargo_cut_off_date].present?)
        if existing_booking_info.cargo_cut_off_date.nil?
          Task.create!(note: 'Cargo cut off date set.', due_date: params[:fcl_exw_booking_info_step][:cargo_cut_off_date], fcl_exw_booking_info_steps_id: existing_booking_info.id, operation_id: Operation.find_by(secure_id: params[:operation_secure_id]).id, subject: 'Cargo Cut Off Date' )
        else
          Task.where(subject: 'Cargo Cut Off Date', fcl_exw_booking_info_steps_id: existing_booking_info.id).first.update!(due_date: params[:fcl_exw_booking_info_step][:cargo_cut_off_date], status: '0')
        end
      end
    end

    def self.create_vgm_cut_off_tasks(params, existing_booking_info)
      if (params[:fcl_exw_booking_info_step][:vgm_cut_off_date].present?)
        if existing_booking_info.vgm_cut_off_date.nil?
          Task.create!(note: 'VGM cut off date set.', due_date: params[:fcl_exw_booking_info_step][:vgm_cut_off_date], fcl_exw_booking_info_steps_id: existing_booking_info.id, operation_id: Operation.find_by(secure_id: params[:operation_secure_id]).id, subject: 'VGM Cut Off Date' )
        else
          Task.where(subject: 'VGM Cut Off Date', fcl_exw_booking_info_steps_id: existing_booking_info.id).first.update!(due_date: params[:fcl_exw_booking_info_step][:vgm_cut_off_date], status: '0')
        end
      end
    end

    def self.create_sailing_date_tasks(params, existing_booking_info)
      if (params[:fcl_exw_booking_info_step][:sailing_date].present?)
        if existing_booking_info.sailing_date.nil?
          Task.create!(note: 'Expected sailing date set.', due_date: params[:fcl_exw_booking_info_step][:sailing_date], fcl_exw_booking_info_steps_id: existing_booking_info.id, operation_id: Operation.find_by(secure_id: params[:operation_secure_id]).id, subject: 'Sailing Date' )
          Task.create!(note: 'Check if cargo is on port and ready to sail', due_date: (params[:fcl_exw_booking_info_step][:arrival_date]).to_date - 3.days, fcl_exw_booking_info_steps_id: existing_booking_info.id, operation_id: Operation.find_by(secure_id: params[:operation_secure_id]).id, subject: 'Cargo On Port' )
        else
          Task.where(subject: 'Sailing Date', fcl_exw_booking_info_steps_id: existing_booking_info.id).first.update!(due_date: params[:fcl_exw_booking_info_step][:sailing_date], status: '0')
          Task.where(subject: 'Cargo On Port', fcl_exw_booking_info_steps_id: existing_booking_info.id).first.update!(due_date: (params[:fcl_exw_booking_info_step][:sailing_date]).to_date - 3.days, status: '0')
        end
      end
    end

    def self.create_arrival_date_tasks(params, existing_booking_info)
      if (params[:fcl_exw_booking_info_step][:arrival_date].present?)
        if existing_booking_info.arrival_date.nil?
          Task.create!(note: 'Expected arrival date set.', due_date: params[:fcl_exw_booking_info_step][:arrival_date], fcl_exw_booking_info_steps_id: existing_booking_info.id, operation_id: Operation.find_by(secure_id: params[:operation_secure_id]).id, subject: 'Arrival Date' )
        else
          Task.where(subject: 'Arrival Date', fcl_exw_booking_info_steps_id: existing_booking_info.id).first.update!(due_date: params[:fcl_exw_booking_info_step][:arrival_date], status: '0')
        end
      end
    end

    def self.create_ramp_cut_off_tasks(params, existing_booking_info)
      existing_task = Task.where(subject: 'Ramp Cut Off Date', fcl_exw_booking_info_steps_id: existing_booking_info.id).first
      if (params[:fcl_exw_booking_info_step][:ramp] == "YES")
        if existing_task.nil? && !(params[:fcl_exw_booking_info_step][:ramp_cut_off_date]).nil?
          Task.create!(note: 'Verify that container was included in ramp transportation.', due_date: (params[:fcl_exw_booking_info_step][:ramp_cut_off_date]).to_date + 1.day , fcl_exw_booking_info_steps_id: existing_booking_info.id, operation_id: Operation.find_by(secure_id: params[:operation_secure_id]).id, subject: 'Ramp Cut Off Date' )
        elsif !(params[:fcl_exw_booking_info_step][:ramp_cut_off_date]).nil?
          existing_task.update!(due_date: params[:fcl_exw_booking_info_step][:ramp_cut_off_date], status: '0')
        end
      elsif (params[:fcl_exw_booking_info_step][:ramp] == "NO")
        unless existing_task.nil?
          existing_task.delete!
        end
      end
    end
end
