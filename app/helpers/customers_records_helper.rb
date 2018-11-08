module CustomersRecordsHelper
	def company_name(customer_id)
		User.find(customer_id).company_name
	end
end
