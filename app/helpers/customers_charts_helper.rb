module CustomersChartsHelper
	def representatives
		User.representatives.map { |user| [user.contact_first_name + " " + user.contact_last_name , user.id] }
	end

	def customers
		(User.agents + User.shippers).map { |user| [user.company_name, user.id] }
	end
end
