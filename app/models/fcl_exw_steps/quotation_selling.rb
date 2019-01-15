module FclExwSteps  	
	class QuotationSelling < ApplicationRecord
		self.table_name = 'fcl_exw_steps_quotation_sellings'
		mount_uploaders :files, FileUploader
		
		def filename
		  File.basename(path)
		end
	end
end