class FclExwOperationMailer < ApplicationMailer

	def booking_info (agent, representative, info)
	  @agent = agent
	  @info = info
	  @operation = Operation.find(info.operation_id)
	  @pieces = FclExwCargoInfoStep.find_by(operation_id: @operation.id).pieces
	  @reference_number = @operation.reference_number
	  attachments.inline["signature.png"] = File.read("#{Rails.root}/app/assets/images/signature.png")
	  delivery_options = { user_name: representative.email,
	                       password: representative.outlook_password
	                     }
	  mail(to: agent.email,
	       subject: "Booking information updated",
	       delivery_method_options: delivery_options, from: representative.email, cc: representative.email)
	end


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

	def request_booking (shipper, operation, carrier, additional_message, representative)
		@shipper  = shipper
		@operation = operation	

		@pieces = operation[1].pieces
		@carrier = carrier
		@additional_message = additional_message
		attachments.inline["signature.png"] = File.read("#{Rails.root}/app/assets/images/signature.png")
		delivery_options = { user_name: representative.email,
                     password: representative.outlook_password
                   }
		mail(to: carrier.email,
		     subject: "INTERWORLD FREIGHT BOOKING ORDER",
		     delivery_method_options: delivery_options, from: representative.email)
	end

	def request_booking_notification (agent, operation, carrier, representative)
		@agent  = agent
		@operation = operation
		@carrier = carrier

		attachments.inline["signature.png"] = File.read("#{Rails.root}/app/assets/images/signature.png")
		delivery_options = { user_name: representative.email,
                     password: representative.outlook_password
                   }
		mail(to: agent.email,
		     subject: "INTERWORLD FREIGHT BOOKING ORDER",
		     delivery_method_options: delivery_options, from: representative.email)
	end

	def container_loading (agent, operation,shipper, representative)
		@agent  = agent
		@operation = operation
		@pieces = FclExwCargoInfoStep.find_by(operation_id: @operation.id).pieces
		@shipper = shipper
		@pickup = FclExwCargoInfoStep.find_by(operation_id: @operation).pickup_reference
		attachments.inline["signature.png"] = File.read("#{Rails.root}/app/assets/images/signature.png")
		delivery_options = { user_name: representative.email,
	                       password: representative.outlook_password
	                     }
		mail(to: agent.email,
		     subject: "Cargo loading confirmation",
		     delivery_method_options: delivery_options, from: representative.email, cc: shipper.email)
	end

	def container_delivery (agent, operation, shipper, representative)
		@agent  = agent
		@operation = operation
		@shipper = shipper
		@pickup = FclExwCargoInfoStep.find_by(operation_id: @operation).pickup_reference

		attachments.inline["signature.png"] = File.read("#{Rails.root}/app/assets/images/signature.png")
		delivery_options = { user_name: representative.email,
	                       password: representative.outlook_password
	                     }
		mail(to: agent.email,
		     subject: "Cargo delivery confirmation",
		     delivery_method_options: delivery_options, from: representative.email, cc: shipper.email)
	end

	def request_sli(shipper, representative, link)
		@shipper = shipper
		@link = link
		attachments.inline["signature.png"] = File.read("#{Rails.root}/app/assets/images/signature.png")
		delivery_options = { user_name: representative.email,
	                       password: representative.outlook_password
	                     }
		mail(to: shipper.email,
		     subject: "Please provide us your SLI information",
		     delivery_method_options: delivery_options, from: representative.email, cc: shipper.email)
	end

	def request_invoice(shipper, representative, link)
		@shipper = shipper
		@link = link
		attachments.inline["signature.png"] = File.read("#{Rails.root}/app/assets/images/signature.png")
		delivery_options = { user_name: representative.email,
	                       password: representative.outlook_password
	                     }
		mail(to: shipper.email,
		     subject: "Please provide us your Invoice information",
		     delivery_method_options: delivery_options, from: representative.email, cc: shipper.email)
	end

	def send_insurance_info(link, operation, representative)
		@link = link
		@operation = operation
		attachments.inline["signature.png"] = File.read("#{Rails.root}/app/assets/images/signature.png")
		delivery_options = { user_name: representative.email,
	                       password: representative.outlook_password
	                     }
		mail(to: 'daniel@daniel.com',
		     subject: "Insurance Information",
		     delivery_method_options: delivery_options, from: representative.email, cc: 'sebas@sebas.com')
	end

end
