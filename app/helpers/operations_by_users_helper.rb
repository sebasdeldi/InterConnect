module OperationsByUsersHelper

	def agents(current_user)
		current_user.relateds.where(role_id: 3)
	end

	def shippers(current_user)
		current_user.relateds.where(role_id: 4)
	end

	def all_representatives
		User.representatives
	end

	def all_consignees
		User.consignees
	end

	def new_operation
		OperationsByUser.new
	end

end
