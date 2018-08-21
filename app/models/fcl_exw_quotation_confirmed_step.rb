class FclExwQuotationConfirmedStep < ApplicationRecord
	has_many :tasks
	belongs_to :operation

	mount_uploaders :files, FileUploader

	def filename
	  File.basename(path)
	end
end
