desc "This task is called by the Heroku scheduler add-on"

task :confirm_info_email => :environment do
	Operation.send_fcl_exw_info_confirmation
end

task :confirm_quotation_email => :environment do
	Operation.send_fcl_exw_info_confirmation
end