class Operation < ApplicationRecord
	has_one :general_cargo_info
	has_many :operations_by_users

	def self.send_fcl_exw_info_confirmation
		operations = Operation.where(fcl_exw_info_requested: true, fcl_exw_info_confirmed: false)
		operations.each do |operation|
			OperationsByUser.where(operation_id: operation.id).each do |pair|
				FclExwOperationMailer.info_confirmation(pair.shipper, pair.representative, pair.agent).deliver_now
			end
		end
	end

	def self.send_fcl_exw_quotation_confirmation
		operations = Operation.where(fcl_exw_quotation_confirmed: false)
		operations.each do |operation|
			OperationsByUser.where(operation_id: operation.id).each do |pair|
				FclExwOperationMailer.info_confirmation(pair.shipper, pair.representative, pair.agent).deliver_now
			end
		end
	end

	def fetch_operations (sort_param ,modality_param=nil, status_param=nil, search_param=nil, current_user, user_id)
		if modality_param == "ALL"
			modality_param = nil
		end

		if status_param == 'ALL'
			status_param = nil
		end

		operations = query_operations(set_operations(current_user), sort_param ,modality_param, status_param, search_param, nil, nil, current_user)

		if !user_id.nil?
			operations = operations.where(representative_id: user_id).or(operations.where(agent_id: user_id)).or(operations.where(shipper_id: user_id))
		end
		sort_operations(sort_param, operations)
	end

	def fetch_charts (date_range ,modality_param=nil, search_param=nil, representative_id_param=nil, customer_id_param=nil)
		if modality_param == "ALL"
			modality_param = nil
		end

		all_operations = query_operations(set_operations, date_range ,modality_param, nil, search_param, representative_id_param, customer_id_param, nil)
		comleted_operations = query_operations(set_operations.where('operations.status =?', 'COMPLETED'), date_range ,modality_param, nil, search_param, representative_id_param, customer_id_param, nil)
		in_progress_operations = query_operations(set_operations.where.not('operations.status =?', 'COMPLETED'), date_range ,modality_param, nil,search_param, representative_id_param,customer_id_param, nil)
		
		if !customer_id_param.nil?
			all_operations = all_operations.where(agent_id: customer_id_param).or(all_operations.where(shipper_id: customer_id_param))
			comleted_operations = comleted_operations.where(agent_id: customer_id_param).or(comleted_operations.where(shipper_id: customer_id_param))
			in_progress_operations = in_progress_operations.where(agent_id: customer_id_param).or(in_progress_operations.where(shipper_id: customer_id_param))
		end

		charts_info = [
			set_charts_date_range(all_operations, date_range), 
			set_charts_date_range(comleted_operations, date_range), 
			set_charts_date_range(in_progress_operations, date_range) 
		]
	end

	private

		def set_charts_date_range(operations, date_range)
			if date_range == "day"
				operations
					.references(:operations)
					.group_by_day('operations.created_at')
					.count
			elsif date_range == "week"
				operations
					.references(:operations)
					.group_by_week('operations.created_at')
					.count
			elsif date_range == "month"
				operations
					.references(:operations)
					.group_by_month('operations.created_at')
					.count
			elsif date_range == "year"
				operations
					.references(:operations)
					.group_by_year('operations.created_at')
					.count
			end				
		end

		def set_operations(current_user=nil)
			if current_user == nil
				operations = OperationsByUser
					.includes(:operation)
					.includes(:agent)
					.includes(:shipper)
			else
				operations = OperationsByUser
					.where(representative_id: current_user.id)
					.includes(:operation)
					.includes(:agent)
					.includes(:shipper)
			end
			operations
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
				.where('operations.status ilike ?', "%"+status_param+"%")
				.references(:operations)
		end

		def query_by_search (search_param, current_user)
			user_ids = User.where('company_name ilike ?', "%"+search_param+"%")
			if current_user.nil?
				OperationsByUser
					.where(agent_id: user_ids)
					.or(OperationsByUser.where(shipper_id: user_ids))
					.includes(:operation)
					.references(:operations)
			else
				OperationsByUser.where(representative_id: current_user)
					.where(agent_id: user_ids)
					.or(OperationsByUser.where(shipper_id: user_ids))
					.includes(:operation)
					.references(:operations)
			end
		end

		def query_by_modality_and_status (operations, modality_param, status_param)
			operations
				.where('operations.modality = ?', modality_param)
				.where('operations.status ilike ?', "%"+status_param+"%")
				.references(:operations)
		end

		def query_by_modality_and_search (operations, modality_param, search_param, current_user)
			user_ids = User.where('company_name ilike ?', "%"+search_param+"%")
			if current_user.nil?
				OperationsByUser
					.where('operations.modality = ?', modality_param)
					.where(agent_id: user_ids)
					.or(OperationsByUser.where(shipper_id: user_ids))
					.includes(:operation)
					.references(:operations)
			else
				OperationsByUser.where(representative_id: current_user)
					.where('operations.modality = ?', modality_param)
					.where(agent_id: user_ids)
					.or(OperationsByUser.where(shipper_id: user_ids))
					.includes(:operation)
					.references(:operations)
			end

		end

		def query_by_status_and_search (operations, status_param, search_param, current_user)
			user_ids = User.where('company_name ilike ?', "%"+search_param+"%")
			if current_user.nil?
				OperationsByUser
					.where('operations.status = ?', status_param)
					.where(agent_id: user_ids)
					.or(OperationsByUser.where(shipper_id: user_ids))
					.includes(:operation)
					.references(:operations)
			else
				OperationsByUser.where(representative_id: current_user)
					.where('operations.status = ?', status_param)
					.where(agent_id: user_ids)
					.or(OperationsByUser.where(shipper_id: user_ids))
					.includes(:operation)
					.references(:operations)
			end
		end

		def query_by_status_and_modality_and_search (operations, modality_param, status_param, search_param, current_user)
			user_ids = User.where('company_name ilike ?', "%"+search_param+"%")
			if current_user.nil?
				OperationsByUser
					.where('operations.modality = ?', modality_param)
					.where('operations.status = ?', status_param)
					.where(agent_id: user_ids)
					.or(OperationsByUser.where(shipper_id: user_ids))
					.includes(:operation)
					.references(:operations)
			else
				OperationsByUser.where(representative_id: current_user)
					.where('operations.modality = ?', modality_param)
					.where('operations.status = ?', status_param)
					.where(agent_id: user_ids)
					.or(OperationsByUser.where(shipper_id: user_ids))
					.includes(:operation)
					.references(:operations)
			end

		end

		def query_by_representative(operations, representative_id)
			operations.where(representative_id: representative_id)
		end

		def query_by_representative_and_modality(operations, representative_id_param, modality_param)
			operations.where(representative_id: representative_id)
				.where('operations.modality = ?', modality_param)
				.includes(:operation)
				.references(:operations)
		end

		def sort_operations(sort_param, operations)
			if sort_param == "newest"
				operations.order(created_at: :desc)
			elsif sort_param == "oldest"
				operations.order(created_at: :asc)
			elsif sort_param == "more_progress"
				operations.order('operations.current_step DESC')
			elsif sort_param == 'less_progress'
				operations.order('operations.current_step ASC')
			else
				operations.order(created_at: :desc)
			end	
		end


		def query_operations(operations=nil, sort_param=nil ,modality_param=nil, status_param=nil, search_param=nil, representative_id_param=nil, customer_id_param=nil,current_user=nil)
			if !modality_param.nil? && status_param.nil? && is_search_empty?(search_param)
				query_by_modality(operations, modality_param)
			elsif !status_param.nil? && modality_param.nil? && is_search_empty?(search_param)
				query_by_status(operations, status_param)
			elsif !is_search_empty?(search_param) && modality_param.nil? && status_param.nil?
				query_by_search(search_param, current_user)
			elsif !modality_param.nil? && !status_param.nil? && is_search_empty?(search_param)
				query_by_modality_and_status(operations, modality_param, status_param)
			elsif !modality_param.nil? && !is_search_empty?(search_param) && status_param.nil?
				query_by_modality_and_search(operations, modality_param, search_param, current_user)
			elsif !status_param.nil? && !is_search_empty?(search_param) && modality_param.nil?
				query_by_status_and_search(operations, status_param, search_param, current_user)
			elsif !status_param.nil? && !is_search_empty?(search_param) && !modality_param.nil?
				query_by_status_and_modality_and_search(operations, modality_param, status_param, search_param, current_user)
			elsif modality_param.nil? && !representative_id_param.nil?
				query_by_representative(operations, representative_id_param)
			elsif !modality_param.nil? && !representative_id_param.nil?
				query_by_representative_and_modality(operations, representative_id_param, modality_param)
			else
				operations
			end
		end

end
