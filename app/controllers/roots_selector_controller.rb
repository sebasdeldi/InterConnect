class RootsSelectorController < ApplicationController
  def index
    path = ''
    if current_user.role_id == Role.find_by(name: 'admin').id
      path = admin_path
    else
      path = representative_path
    end    
    redirect_to path     
  end
end