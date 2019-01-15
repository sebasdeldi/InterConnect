module FclExwSteps  	
	class FclExwQuotationSellingStep < ApplicationRecord
		mount_uploaders :files, FileUploader
		
		def filename
		  File.basename(path)
		end
	end
end