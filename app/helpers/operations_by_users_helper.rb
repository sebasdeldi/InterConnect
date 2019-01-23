module OperationsByUsersHelper

	def agents(current_user)
		User.relateds(current_user.id).where(role_id: 3)
	end

	def shippers(current_user)
		User.relateds(current_user.id).where(role_id: 4)
	end

	def all_representatives
		User.representatives
	end

	def all_consignees
		User.consignees
	end

	def new_operation
		Operations::OperationsByUser.new
	end

end
