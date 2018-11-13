module OperationsByUsersHelper

	def agents(current_user)
		current_user.relateds.where(role_id: 3)
	end

	def shippers(current_user)
		current_user.relateds.where(role_id: 4)
	end

	def representatives
		User.representatives
	end

	def consignees
		User.consignees
	end

end
