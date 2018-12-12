module UsersRelationshipHelper
	def shippers_relationships
  	User.shippers.order('company_name ASC')
	end

	def agents_relationships
		User.agents.order('company_name ASC')
	end

	def consignees_relationships
		
	end
end
