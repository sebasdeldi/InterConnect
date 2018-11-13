module CustomersChartsHelper
	def representatives
		User.representatives.map { |user| [user.company_name, user.id] }
	end

	def customers
		(User.agents + User.shippers).map { |user| [user.company_name, user.id] }
	end

	def modality
		cookies[:modality]
	end

	def customer_id
		cookies[:customer_id]
	end
end
