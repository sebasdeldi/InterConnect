class TeamController < ApplicationController
	def index
		@representatives = User.representatives
		@team = Team.find_by(team_leader: current_user.id)
		@team_members = User.where(team_id: @team.id)

		if request.post?
			if params[:delete].present? 
				User.find(params[:representative_id]).update(team_id: nil)
			else
				User.find(params[:representative_id]).update(team_id: @team.id)
			end
		end

		@operations = OperationsByUser.where(representative_id: User.where(team_id: Team.where(team_leader: current_user.id)))
	end

	def show
		@representative = User.find(params[:id])
		@operations = OperationsByUser.where(representative_id: params[:id])
	end

	def change_representative
		OperationsByUser.find(params[:operation_id]).update(representative_id: params[:representative])
		redirect_back(fallback_location: authenticated_root_path)
	end
end
