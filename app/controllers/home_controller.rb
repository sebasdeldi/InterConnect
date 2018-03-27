class HomeController < ApplicationController
  def index
  	if is_representative?
  		@operations_by_user = OperationsByUser.where(representative_id: current_user.id).includes(:operation).includes(:agent)
  	elsif is_agent?
  		@operations_by_user = OperationsByUser.where(agent_id: current_user.id).includes(:operation).includes(:agent).includes(:representative)
  	end
  end
end
