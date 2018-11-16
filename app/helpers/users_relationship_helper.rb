module UsersRelationshipHelper
	def shippers_relationships
  	User.shippers
	end

	def agents_relationships
		User.agents
	end
end
