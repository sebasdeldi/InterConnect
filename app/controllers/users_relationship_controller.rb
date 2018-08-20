class UsersRelationshipController < ApplicationController
  def create
  	UsersRelationship.create(user_id: params[:representative_id], related_id: params[:related_id] )
  	flash[:notice] = 'Relation created'
  	redirect_back(fallback_location: authenticated_root_path)
  end

  def destroy
  	UsersRelationship.where(user_id: params[:representative_id], related_id: params[:related_id]).first.delete
  	flash[:notice] = 'Relation deleted'
  	redirect_back(fallback_location: authenticated_root_path)
  end

  def index
  end

  def new
  	@representative = User.find(params[:representative_id])
  	@agents = User.agents
  	@shippers = User.shippers
  	@relateds = @representative.relateds
  end

  def index_representatives
  	@representatives = User.representatives
  end
end
