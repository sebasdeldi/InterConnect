module Operations
  class OperationsByUser < ApplicationRecord
    belongs_to :operation
    belongs_to :representative, class_name: 'User', foreign_key: "representative_id"
    belongs_to :agent, class_name: 'User', foreign_key: "agent_id", optional: true
    belongs_to :shipper, class_name: 'User', foreign_key: "shipper_id", optional: true
    belongs_to :consignee, class_name: 'User', foreign_key: "consignee_id", optional: true
    validates :agent_id, :shipper_id, :consignee_id, :operation_id, presence: true

    # fields is an array conteining [ reference, modality, strong_params_for_representatives, current_user, pieces_number ]
    def self.create_for_representatives(fields)
  		operation = create_operation(fields[1], fields[0], fields[4], fields[6], fields[7], fields[8], fields[9], fields[10], fields[11], fields[12], fields[13], fields[14], fields[15], fields[16])
  		@operations_by_user = Operations::OperationsByUser.create(fields[2].merge(operation_id: operation.id, representative_id: fields[3].id))
      errors = (@operations_by_user.errors.full_messages + operation.errors.full_messages).delete_if {|x| x == "Operation must exist" || x == "Operation can't be blank"}
      [@operations_by_user, errors]
    end

    def self.update_for_representatives(fields, operation_id, current_user)
      op = Operation.find operation_id
      update_operation(fields[2], fields[3], fields[4], fields[5], fields[6], fields[7], fields[8], fields[9], fields[10], fields[11], fields[12], op)
      Operations::OperationsByUser.find_by(operation_id: operation_id).update(fields[0].merge(operation_id: op.id, representative_id: current_user.id))
      @operations_by_user = Operations::OperationsByUser.find_by(operation_id: operation_id)
      errors = (@operations_by_user.errors.full_messages + op.errors.full_messages).delete_if {|x| x == "Operation must exist" || x == "Operation can't be blank"}
      [@operations_by_user, errors]
    end

    def self.create_operation_by_representative(params, current_user, strong_params)
      params[:operations_operations_by_user][:agent_id].present? && params[:operations_operations_by_user][:shipper_id].present?
      date_arr = Date.today.to_s.split('-') 
      reference = (current_user.contact_first_name[0..0] + current_user.contact_last_name[0..0] + date_arr[2] + date_arr[1] + date_arr[0][2..4] + last_two_digits).upcase
      fields = [ reference, params[:modality], strong_params, current_user, params[:pieces_number], '', params[:agent_reference], params[:shipper_reference],
      params[:consignee_reference], params[:pol], params[:pod], params[:origin_address], params[:origin_city], params[:origin_state], params[:origin_zip_code], params[:origin_country], params[:destination] ]
      new_operation = create_for_representatives(fields)
    end

    def self.update_operation_by_representative(params, current_user, strong_params, operation_id)
      fields = [ strong_params, current_user, params[:agent_reference], params[:shipper_reference],
      params[:consignee_reference], params[:pol], params[:pod], params[:origin_address], params[:origin_city], params[:origin_state], params[:origin_zip_code], params[:origin_country], params[:destination] ]
      updated_operation = update_for_representatives(fields, operation_id, current_user)
    end

    private
    	def self.create_operation(modality, reference, pieces_number, agent_reference, shipper_reference, consignee_reference, pol, pod, origin_address, origin_city, origin_state, origin_zip_code, origin_country, destination)
    		steps_number = 1
    		if modality == "FCL - EXW"
    			steps_number = 9
    			#TODO add other modality cases
    		end
        last_two_digits
    		operation = Operation.create(reference: reference, status: 'IN PROGRESS', status_message:'Confirm quotation', 
          modality: modality, steps_number: steps_number, current_step: 0, pieces_number: pieces_number, agent_reference: agent_reference,
          pol: pol, pod: pod, origin_address: origin_address, origin_city: origin_city, origin_state: origin_state, origin_zip_code: origin_zip_code, origin_country: origin_country,
          destination: destination, shipper_reference: shipper_reference, consignee_reference: consignee_reference)
        create_steps(operation)
        operation
      end

      def self.update_operation(agent_reference, shipper_reference, consignee_reference, pol, pod, origin_address, origin_city, origin_state, origin_zip_code, origin_country, destination, operation)
        operation.update(agent_reference: agent_reference,
          pol: pol, pod: pod, origin_address: origin_address, origin_city: origin_city, origin_state: origin_state, origin_zip_code: origin_zip_code, origin_country: origin_country,
           destination: destination, shipper_reference: shipper_reference, consignee_reference: consignee_reference)
      end

      def self.create_steps(operation)
        FclExwSteps::ContainerDelivery.create!(operation: operation)
        FclExwSteps::ContainerLoading.create!(operation: operation)
        FclExwSteps::InfoConfirmed.create!(operation: operation)
        CommonSteps::QuotationConfirmed.create!(operation: operation)
        CommonSteps::InfoRequested.create!(operation: operation)
        FclExwSteps::RequestBooking.create!(operation: operation)
        Documents::QuotationSelling.create!(operation_id: operation.id)
        Documents::Insurance.create!(operation: operation)
        cargo_info = FclExwSteps::CargoInfo.new(operation: operation)
        cargo_info.save!(validate: false)
        booking_info = FclExwSteps::BookingInfo.new(operation: operation)
        booking_info.save!(validate: false)
      end

      def self.last_two_digits
        if ((Operation.last.nil?) || (Operation.last.created_at < Time.current.beginning_of_day))
          "00"
        else
          ref = (Operation.last.reference.last(2).to_i + 1).to_s
          if ref.length == 1
            ref = '0' + ref
          end
          ref
        end
      end
  end
end