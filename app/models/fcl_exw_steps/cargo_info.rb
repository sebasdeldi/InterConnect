module FclExwSteps    
  class CargoInfo < ApplicationRecord
    self.table_name = 'fcl_exw_steps_cargo_infos'
    
  	strip_attributes
    belongs_to :operation
    has_many :tasks
    has_many :pieces, dependent: :destroy
  	accepts_nested_attributes_for :pieces, allow_destroy: true
    mount_uploaders :files, FileUploader

    def filename
      File.basename(path)
    end

    def self.create_cargo_info(params, fcl_cargo_info_params)
    	op = Operation.find_by(secure_id: params[:operation_secure_id])
    	existing_cargo_info = FclExwSteps::CargoInfo.find_by(operation_id: op)
      if existing_cargo_info.created_at == existing_cargo_info.updated_at
        op.update(fcl_exw_quotation_confirmed: true, status: 'IN PROGRESS', current_step: op.current_step + 1, status_message: 'Request Booking Order')
      end
      if existing_cargo_info.update(fcl_cargo_info_params.merge(operation_id: op.id))
        create_bonded_task(params, op)
  			create_self_propelled_task(params, op)
  			create_quotation_verification_task(op)
  			update_shipper_ein(params, op)		
    		params_array = params.to_unsafe_h.to_a
    		create_pieces(params_array, existing_cargo_info)
    		true
    	else
    		false
    	end	
    end

    private
  	  def self.create_pieces (params_array, cargo_info)
  	  	CommonSteps::Piece.where(fcl_exw_steps_cargo_info_id: cargo_info.id).delete_all
        puts params_array.to_s

  	  	params_array = params_array.drop(3)[0..-4]
        (0..params_array.length).step(6) do |element|
        	unless params_array[element].nil?
          	piece = CommonSteps::Piece.create(fcl_exw_steps_cargo_info_id: cargo_info.id, gross_weight: params_array[element][1], commercial_description: params_array[element+1][1], container_size: params_array[element+2][1], cargo_hazardous: params_array[element+3][1], hazardous_class: params_array[element+4][1], un_code: params_array[element+5][1] )
        	end
        end
      end

    	def self.create_bonded_task(params, op)
    		existing_bonded = Generals::Task.find_by(operation_id: op.id, subject: 'Bonded Docummentation')
    		if params[:fcl_exw_steps_cargo_info][:bonded] == 'true'
    			if existing_bonded.nil?
    				Generals::Task.create(operation_id: op.id, note: 'Verify bonded docummentation', due_date: Time.now + 1.weeks , subject:'Bonded Docummentation')				
    			else
    				existing_bonded.update(status: '0')
    			end
    		else
    			if !existing_bonded.nil?
    				existing_bonded.update(status: '1')
    			end
    		end
    	end

    	def self.create_self_propelled_task(params, op)
    		existing_self_propelled = Generals::Task.find_by(operation_id: op.id, subject: 'Self Propelled Docummentation')
    		if params[:fcl_exw_steps_cargo_info][:self_propelled] == 'true'
    			if existing_self_propelled.nil?
    				Generals::Task.create(operation_id: op.id, note: "Send self propelled docummentation (tittle/bill of sells original & notarized, power of attorney, copy of power of attorney signer's id) to broker", due_date: Time.now + 1.weeks , subject:'Self Propelled Docummentation')				
    			else
    				existing_self_propelled.update(status: '0')
    			end
    		else
    			if !existing_self_propelled.nil?
    				existing_self_propelled.update(status: '1')
    			end
    		end
    	end

    	def self.create_quotation_verification_task(op)
    		unless Generals::Task.find_by(operation_id: op.id, subject: 'Quotation Review')
    			Generals::Task.create(note: "Please verify that your POD, POL, container size, loading address and hazmat status match the operation's quotation. Also be aware of any overweight extra fee (20' bellow 35.000lbs, 40' and 45' bellow 42.000)", due_date: Time.now + 4.days, operation_id: op.id, subject: 'Quotation Review' )
    		end
    	end

    	def self.update_shipper_ein(params, op)
    		shipper = Operations::OperationsByUser.find_by(operation_id: op.id).shipper
    		if shipper.ein != params[:fcl_exw_steps_cargo_info][:ein]
          shipper.update_attribute('ein', params[:fcl_exw_steps_cargo_info][:ein])
    		end
    	end

  end
end