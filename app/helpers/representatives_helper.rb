module RepresentativesHelper
	def task_subject
		Generals::Task.distinct.pluck(:subject)
	end
end
