module Users
  class RelationshipsController < ApplicationController
    def create
    	Users::Relationship.create(user_id: params[:representative_id], related_id: params[:related_id] )
    	flash[:notice] = 'Relation created'
    	redirect_back(fallback_location: authenticated_root_path)
    end

    def destroy
    	Users::Relationship.where(user_id: params[:representative_id], related_id: params[:related_id]).first.delete
    	flash[:notice] = 'Relation deleted'
    	redirect_back(fallback_location: authenticated_root_path)
    end

    def index
    end

    def new
    	@representative = User.find(params[:representative_id])
    	@relateds = User.relateds(params[:representative_id]).order('company_name ASC')
    end

    def index_representatives
    	@representatives = User.representatives
    end
  end
end
