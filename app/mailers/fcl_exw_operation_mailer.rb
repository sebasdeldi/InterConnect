class FclExwOperationMailer < ApplicationMailer

	def info_request (shipper, representative, agent)
	  @shipper  = shipper
	  @agent = agent
	  attachments.inline["signature.png"] = File.read("#{Rails.root}/app/assets/images/signature.png")
	  delivery_options = { user_name: representative.email,
	                       password: representative.outlook_password
	                     }
	  mail(to: shipper.email,
	       subject: "Please see the Terms and Conditions attached",
	       delivery_method_options: delivery_options, from: representative.email, cc: representative.email)
	end

	def info_confirmation (shipper, representative, agent)
	  @shipper  = shipper
	  @agent = agent
	  attachments.inline["signature.png"] = File.read("#{Rails.root}/app/assets/images/signature.png")
	  delivery_options = { user_name: 'no-reply@interwf.com',
	                       password: 'Nriwf**321'
	                     }
	  mail(to: representative.email,
	       subject: "Please remember to contact your shipper",
	       delivery_method_options: delivery_options, from: 'no-reply@interwf.com')
	end

end
