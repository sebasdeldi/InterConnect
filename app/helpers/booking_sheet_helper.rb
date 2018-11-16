module BookingSheetHelper
	def self_propelled_task(operation)
		Task.find_by(operation_id: operation, subject: 'Self Propelled Docummentation')
	end
end
