module GeneralRecordsHelper
	def modality
		cookies[:modality]
	end

	def status
		cookies[:status]
	end

	def search
		cookies[:search]
	end
end
