module RecordsLists  
  class Customer
    include OperationQueriable
    include OperationSortable

    # query_params is an array where elements are:
    	# 1) modality
    	# 2) status
    	# 3) search
    def self.fetch_customers_operations(sort_param, query_params, customer_id)
    	query_params[0] = query_params[0] == 'ALL' ? nil : query_params[0]
    	query_params[1] = query_params[1] == 'ALL' ? nil : query_params[1]

    	operations = query_customers_operations(set_general_operations, query_params, customer_id)
    	sort_operations(sort_param, operations)
    end 

    private
    	# query_params is an array where elements are:
    		# 1) modality
    		# 2) status
    		# 3) search
    	def self.query_customers_operations(operations, query_params, customer_id)
    		modality_param = query_params[0] == '' ? nil : 	query_params[0]    
    		status_param = query_params[1] == '' ? nil : 	query_params[1]
    		search_param = query_params[2] == '' ? nil : 	query_params[2]

    		if !modality_param.nil? && status_param.nil? && is_search_empty?(search_param)
    			query = query_by_modality(operations, modality_param)
    			query.where(agent_id: customer_id)
    				.or(query.where(shipper_id: customer_id))
    		elsif !status_param.nil? && modality_param.nil? && is_search_empty?(search_param)
    			query = query_by_status(operations, status_param)
    			query.where(agent_id: customer_id)
    				.or(query.where(shipper_id: customer_id))
    		elsif !is_search_empty?(search_param) && modality_param.nil? && status_param.nil?
    			query = query_by_search(search_param)
    			query.where(agent_id: customer_id)
    				.or(query.where(shipper_id: customer_id))
    		elsif !modality_param.nil? && !status_param.nil? && is_search_empty?(search_param)
    			query = query_by_modality_and_status(operations, modality_param, status_param)
    			query.where(agent_id: customer_id)
    				.or(query.where(shipper_id: customer_id))
    		elsif !modality_param.nil? && !is_search_empty?(search_param) && status_param.nil?
    			query = query_by_modality_and_search(operations, modality_param, search_param)
    			query.where(agent_id: customer_id)
    				.or(query.where(shipper_id: customer_id))
    		elsif !status_param.nil? && !is_search_empty?(search_param) && modality_param.nil?
    			query = query_by_status_and_search(operations, status_param, search_param)
    			query.where(agent_id: customer_id)
    				.or(query.where(shipper_id: customer_id))
    		elsif !status_param.nil? && !is_search_empty?(search_param) && !modality_param.nil?
    			query = query_by_status_and_modality_and_search(operations, modality_param, status_param, search_param)
    			query.where(agent_id: customer_id)
    				.or(query.where(shipper_id: customer_id))
    		else
    			operations.where(agent_id: customer_id).
    				or(operations.where(shipper_id: customer_id))
    		end
    	end

  end
end