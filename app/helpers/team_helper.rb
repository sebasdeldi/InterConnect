module TeamHelper
	def representatives
		User.representatives
	end

	def team_members(current_user, team)
		User.where(team_id: team)
	end
end
