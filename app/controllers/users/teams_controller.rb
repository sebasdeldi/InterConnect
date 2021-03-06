module Users	
	class TeamsController < ApplicationController
		def index
			@operations = Operations::OperationsByUser.where(representative_id: User.where(team_id: Users::Team.where(team_leader: current_user.id)))
			@difficult_operations = @operations.where('operations.difficulty = ?', 'HARD').includes(:operation).references(:operation) 
			@team = Users::Team.find_by(team_leader: current_user.id)
			if request.post?
				if params[:delete].present? 
					User.find(params[:representative_id]).update(team_id: nil)
				else
					User.find(params[:representative_id]).update(team_id: @team.id)
				end
			end
		end

		def show
			@representative = User.find(params[:id])
			@operations = Operations::OperationsByUser.where(representative_id: params[:id])
		end

		def change_representative
			Operations::OperationsByUser.find(params[:operation_id]).update(representative_id: params[:representative])
			redirect_back(fallback_location: authenticated_root_path)
		end
	end
end