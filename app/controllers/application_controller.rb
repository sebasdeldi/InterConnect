class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :resource_name, :resource, :devise_mapping, :resource_class, :is_admin?, :is_representative?, :is_shipper?,
    :is_agent?


  # Roles detection helpers
  def is_admin?
  	current_role == 'admin' ? true : false
  end

  def is_representative?
  	current_role == 'representative' ? true : false
  end

  def is_shipper?
  	current_role == 'shipper' ? true : false
  end

  def is_agent?
  	current_role == 'agent' ? true : false
  end


  # Devise helpers
  def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end

  def resource_class
    User
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  private
  	def current_role
  		current_role = current_user.nil? ? 'Not logged in' : Role.find(current_user.role_id).name 
  	end

end
