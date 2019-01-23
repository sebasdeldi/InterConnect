module OperationQueriable
  extend ActiveSupport::Concern

  module ClassMethods

    def set_general_operations
      operations = Operations::OperationsByUser
        .includes(:operation)
        .includes(:agent)
        .includes(:shipper)
    end

    def is_search_empty?(search_param)
      if search_param.nil? || search_param == ''
        true
      else
        false
      end
    end

    def query_by_modality (operations, modality_param)
    	operations
    		.where('operations.modality = ?', modality_param)
    		.references(:operations)
    end

    def query_by_status (operations, status_param)
    	operations
    		.where('operations.status = ?',status_param)
    		.references(:operations)
    end

    def query_by_search (search_param)
    	user_ids = User.where('company_name ilike ?', "%"+search_param+"%")
    	OperationsByUser
    		.where(agent_id: user_ids)
    		.or(Operations::OperationsByUser.where(shipper_id: user_ids))
    		.includes(:operation)
    		.references(:operations)
    end

    def query_by_modality_and_status (operations, modality_param, status_param)
    	operations
    		.where('operations.status = ?', status_param)
    		.where('operations.modality = ?', modality_param)
    		.references(:operations)
    end

    def query_by_modality_and_search (operations, modality_param, search_param)
    	user_ids = User.where('company_name ilike ?', "%"+search_param+"%")
    	op = OperationsByUser
    		.where('operations.modality = ?', modality_param)

    	op.where(agent_id: user_ids)
    	.or(op.where(shipper_id: user_ids))
    	.includes(:operation)
    	.references(:operations)
    end

    def query_by_status_and_search (operations, status_param, search_param)
    	user_ids = User.where('company_name ilike ?', "%"+search_param+"%")
    	op = OperationsByUser
    		.where('operations.status = ?', status_param)

    	op.where(agent_id: user_ids)
    		.or(op.where(shipper_id: user_ids))
    		.includes(:operation)
    		.references(:operations)
    end

    def query_by_status_and_modality_and_search (operations, modality_param, status_param, search_param)
    	user_ids = User.where('company_name ilike ?', "%"+search_param+"%")

    	op = OperationsByUser
    		.where('operations.modality = ?', modality_param)
    		.where('operations.status = ?', status_param)

    	op.where(agent_id: user_ids)
    		.or(op.where(shipper_id: user_ids))
    		.includes(:operation)
    		.references(:operations)
    end

    def query_by_representative(operations, representative_id)
    	operations.where(representative_id: representative_id)
    end

    def query_by_customer(operations, customer_id)
    	operations.where(shipper_id: customer_id)
    		.or(operations.where(agent_id: customer_id))
    end

    def query_by_representative_and_modality(operations, representative_id, modality_param)
    	operations.where(representative_id: representative_id)
    		.where('operations.modality = ?', modality_param)
    		.includes(:operation)
    		.references(:operations)
    end

    def query_by_customer_and_modality(operations, customer_id, modality_param)
    	operations.where(shipper_id: customer_id)
    		.or(operations.where(agent_id: customer_id))
    		.where('operations.modality = ?', modality_param)
    		.includes(:operation)
    		.references(:operations)
    end
  end
end