class LclOperationMailer < ApplicationMailer
	add_template_helper(OperationsHelper)
	add_template_helper(ApplicationHelper)

	def request_booking_notification (agent, operation, representative)
		@agent  = agent
		@operation = operation

		attachments.inline["signature.png"] = File.read("#{Rails.root}/app/assets/images/signature.png")
		delivery_options = { user_name: representative.email,
                     password: representative.outlook_password
                   }
		mail(to: agent.email,
		     subject: "INTERWORLD FREIGHT BOOKING ORDER",
		     delivery_method_options: delivery_options, from: representative.email)
	end
end