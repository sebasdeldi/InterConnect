module RepresentativesHelper
	def task_subject
		Task.distinct.pluck(:subject)
	end
end
