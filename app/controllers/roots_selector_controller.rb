class RootsSelectorController < ApplicationController
  def index
    path = ''
    if current_user.role_id == Role.find_by(name: 'admin').id
      path = admin_path
    elsif current_user.role_id == Role.find_by(name: 'representative').id
      path = representative_path
    elsif current_user.role_id == Role.find_by(name: 'team_leader').id
    	path = team_path
    end    
    redirect_to path     
  end
end