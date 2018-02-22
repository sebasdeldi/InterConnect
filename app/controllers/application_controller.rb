class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def is_admin?
  	current_role == 'admin' ? true : false
  end
  helper_method :is_admin?

  def is_agent?
  	current_role == 'agent' ? true : false
  end
  helper_method :is_agent?

  def is_consignee?
  	current_role == 'consignee' ? true : false
  end
  helper_method :is_consignee?

  def is_shipper?
  	current_role == 'shipper' ? true : false
  end
  helper_method :is_shipper?

  private
  	def current_role
  		current_role = Role.find(current_user.role_id).name
  	end

end
