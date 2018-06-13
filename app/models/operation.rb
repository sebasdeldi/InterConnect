class Operation < ApplicationRecord
	has_one :general_cargo_info
	has_many :operations_by_users
	has_many :tasks

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


	# query_params is an array where elements are:
		# 1) modality
		# 2) status
		# 3) search
	def fetch_general_operations(sort_param, query_params)
		query_params[0] = query_params[0] == 'ALL' ? nil : query_params[0]
		query_params[1] = query_params[1] == 'ALL' ? nil : query_params[1]

		operations = query_general_operations(set_general_operations, query_params)
		sort_operations(sort_param, operations)
	end

	# query_params is an array where elements are:
		# 1) modality
		# 2) status
		# 3) search
	def fetch_representative_operations(sort_param, query_params, representative_id)
		query_params[0] = query_params[0] == 'ALL' ? nil : query_params[0]
		query_params[1] = query_params[1] == 'ALL' ? nil : query_params[1]

		operations = query_representative_operations(set_general_operations, query_params, representative_id)
		sort_operations(sort_param, operations)
	end

	# query_params is an array where elements are:
		# 1) modality
		# 2) status
		# 3) search
	def fetch_customers_operations(sort_param, query_params, customer_id)
		query_params[0] = query_params[0] == 'ALL' ? nil : query_params[0]
		query_params[1] = query_params[1] == 'ALL' ? nil : query_params[1]

		operations = query_customers_operations(set_general_operations, query_params, customer_id)
		sort_operations(sort_param, operations)
	end 


	def fetch_general_charts(date_range, modality)

		all_operations = query_general_charts_operations(set_general_operations, modality)
		comleted_operations = query_general_charts_operations(set_general_operations.where('operations.status =?', 'COMPLETED'), modality)
		in_progress_operations = query_general_charts_operations(set_general_operations.where.not('operations.status =?', 'COMPLETED'), modality)

		charts_info = [
			set_charts_date_range(all_operations, date_range), 
			set_charts_date_range(comleted_operations, date_range), 
			set_charts_date_range(in_progress_operations, date_range) 
		]
	end

	def fetch_representatives_charts(date_range, modality, representative)
		modality = modality == 'ALL' ? nil : modality
	
		all_operations = query_representatives_charts(set_general_operations, date_range ,modality, representative)
		comleted_operations = query_representatives_charts(set_general_operations.where('operations.status =?', 'COMPLETED'), date_range, modality, representative)
		in_progress_operations = query_representatives_charts(set_general_operations.where.not('operations.status =?', 'COMPLETED'), date_range, modality, representative)

		charts_info = [
			set_charts_date_range(all_operations, date_range), 
			set_charts_date_range(comleted_operations, date_range), 
			set_charts_date_range(in_progress_operations, date_range) 
		]
	end

	def fetch_customers_charts(date_range, modality, customer_id)
		modality = modality == 'ALL' ? nil : modality

		all_operations = query_customers_charts_operations(set_general_operations, date_range, modality, customer_id)
		comleted_operations = query_customers_charts_operations(set_general_operations.where('operations.status =?', 'COMPLETED'), date_range, modality, customer_id)
		in_progress_operations = query_customers_charts_operations(set_general_operations.where.not('operations.status =?', 'COMPLETED'), date_range, modality, customer_id)

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


		def set_general_operations
			operations = OperationsByUser
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
				.or(OperationsByUser.where(shipper_id: user_ids))
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

		def query_general_charts_operations(operations, modality)
			if modality == "ALL"
				operations
			else
				query_by_modality(operations, modality)
			end
		end

		def query_representatives_charts(operations, date_range, modality, representative)
			if modality == "ALL"
				operations
			else
				if modality.nil? && !representative.nil?
					query_by_representative(operations, representative)
				elsif !modality.nil? && !representative.nil?
					query_by_representative_and_modality(operations, representative, modality)
				else
					operations
				end
			end
		end

		def query_customers_charts_operations(operations, date_range, modality, customer_id)
			if modality == "ALL"
				operations
			else
				if modality.nil? && !customer_id.nil?
					query_by_customer(operations, customer_id)
				elsif !modality.nil? && !customer_id.nil?
					query_by_customer_and_modality(operations, customer_id, modality)
				else
					operations
				end
			end
		end

		# query_params is an array where elements are:
			# 1) modality
			# 2) status
			# 3) search
		def query_general_operations(operations, query_params)
			modality_param = query_params[0]
			status_param = query_params[1]
			search_param = query_params[2]

			if !modality_param.nil? && status_param.nil? && is_search_empty?(search_param)
				query_by_modality(operations, modality_param)
			elsif !status_param.nil? && modality_param.nil? && is_search_empty?(search_param)
				query_by_status(operations, status_param)
			elsif !is_search_empty?(search_param) && modality_param.nil? && status_param.nil?
				query_by_search(search_param)
			elsif !modality_param.nil? && !status_param.nil? && is_search_empty?(search_param)
				query_by_modality_and_status(operations, modality_param, status_param)
			elsif !modality_param.nil? && !is_search_empty?(search_param) && status_param.nil?
				query_by_modality_and_search(operations, modality_param, search_param)
			elsif !status_param.nil? && !is_search_empty?(search_param) && modality_param.nil?
				query_by_status_and_search(operations, status_param, search_param)
			elsif !status_param.nil? && !is_search_empty?(search_param) && !modality_param.nil?
				query_by_status_and_modality_and_search(operations, modality_param, status_param, search_param)
			else
				operations
			end
		end


		# query_params is an array where elements are:
			# 1) modality
			# 2) status
			# 3) search
		def query_representative_operations(operations, query_params, representative_id)
			modality_param = query_params[0]
			status_param = query_params[1]
			search_param = query_params[2]

			if !modality_param.nil? && status_param.nil? && is_search_empty?(search_param)
				query_by_modality(operations, modality_param).where(representative_id: representative_id)
			elsif !status_param.nil? && modality_param.nil? && is_search_empty?(search_param)
				query_by_status(operations, status_param).where(representative_id: representative_id)
			elsif !is_search_empty?(search_param) && modality_param.nil? && status_param.nil?
				query_by_search(search_param).where(representative_id: representative_id)
			elsif !modality_param.nil? && !status_param.nil? && is_search_empty?(search_param)
				query_by_modality_and_status(operations, modality_param, status_param).where(representative_id: representative_id)
			elsif !modality_param.nil? && !is_search_empty?(search_param) && status_param.nil?
				query_by_modality_and_search(operations, modality_param, search_param).where(representative_id: representative_id)
			elsif !status_param.nil? && !is_search_empty?(search_param) && modality_param.nil?
				query_by_status_and_search(operations, status_param, search_param).where(representative_id: representative_id)
			elsif !status_param.nil? && !is_search_empty?(search_param) && !modality_param.nil?
				query_by_status_and_modality_and_search(operations, modality_param, status_param, search_param).where(representative_id: representative_id)
			else
				operations.where(representative_id: representative_id)
			end
		end


		# query_params is an array where elements are:
			# 1) modality
			# 2) status
			# 3) search
		def query_customers_operations(operations, query_params, customer_id)
			modality_param = query_params[0]
			status_param = query_params[1]
			search_param = query_params[2]

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
