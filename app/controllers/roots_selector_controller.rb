class RootsSelectorController < ApplicationController
  def index
    path = ''
    if current_user.role_id == Users::Role.find_by(name: 'admin').id
      path = users_admin_path
    elsif current_user.role_id == Users::Role.find_by(name: 'representative').id
      path = users_representative_path
    elsif current_user.role_id == Users::Role.find_by(name: 'team_leader').id
    	path = users_team_path
    end    
    redirect_to path     
  end
end