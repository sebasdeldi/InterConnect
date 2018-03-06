class HomeController < ApplicationController
  def index
  	@operations_by_user = OperationsByUser.where(representative_id: current_user.id).joins(:operation).joins(:agent)
  end
end
