class FclExwOperationMailer < ApplicationMailer

	def info_request (shipper, representative, agent, secure_id)
	  @shipper  = shipper
	  @agent = agent
	  @secure_id = secure_id
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

	def issue_quotation (shipper, representative, agent, operation)
	  @shipper  = shipper
	  @agent = agent
	  @operation = operation
	  
	  attachments.inline["signature.png"] = File.read("#{Rails.root}/app/assets/images/signature.png")
	  delivery_options = { user_name: representative.email,
	                       password: representative.outlook_password
	                     }
	  mail(to: agent.email,
	       subject: "Quotation request from shipper " + shipper.company_name,
	       delivery_method_options: delivery_options, from: representative.email, cc: 'pricing@interwf.com')
	end

	def quotation_confirmation (shipper, representative, agent)
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

	def request_booking (shipper, operation, carrier, additional_message)
		@shipper  = shipper
		@operation = operation
		@carrier = carrier
		@additional_message = additional_message
		attachments.inline["signature.png"] = File.read("#{Rails.root}/app/assets/images/signature.png")
		delivery_options = { user_name: 'no-reply@interwf.com',
		                     password: 'Nriwf**321'
		                   }
		mail(to: carrier.email,
		     subject: "INTER WORLD FREIGHT BOOKING ORDER",
		     delivery_method_options: delivery_options, from: 'no-reply@interwf.com')
	end

	def request_booking_notification (agent, operation, carrier)
		@agent  = agent
		@operation = operation
		@carrier = carrier

		attachments.inline["signature.png"] = File.read("#{Rails.root}/app/assets/images/signature.png")
		delivery_options = { user_name: 'no-reply@interwf.com',
		                     password: 'Nriwf**321'
		                   }
		mail(to: agent.email,
		     subject: "INTER WORLD FREIGHT BOOKING ORDER",
		     delivery_method_options: delivery_options, from: 'no-reply@interwf.com')
	end

end
