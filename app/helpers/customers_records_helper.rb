module CustomersRecordsHelper
	def company_name(customer_id)
		User.find(customer_id).company_name
	end

	def modality
		cookies[:modality]
	end

	def status
		cookies[:status]
	end

	def search
		cookies[:search]
	end

	def customer_id
		cookies[:customer_id]
	end
end
