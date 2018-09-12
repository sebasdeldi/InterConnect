# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

roles = Role.create!([
	{name: 'admin'},
	{name: 'representative'},
	{name: 'agent'},
	{name: 'shipper'},
	{name: 'vendor'},
	{name: 'carrier'},
	{name: 'pricing_representative'},
	{name: 'consignee'},
	{name: 'pricing'},
	{name: 'team_leader'}
])

users = User.create!([
	{email: 'admin@admin.com', password: '12345678', role_id: 1, company_name: 'Interworld Freight', phone_number: '7862803736', contact_first_name: 'Pepito', contact_last_name: 'Perez'},
	{email: 'leader@leader.com', password: '12345678', role_id: 10, company_name: 'Interworld Freight', phone_number: '7862803736', contact_first_name: 'Daniel', contact_last_name: 'Zapata'},
	{email: 'sdelgado@interwf.com', password: '12345678', role_id: 2, company_name: 'Interworld Freight', phone_number: '7862803736', outlook_password: 'Sdiwf**321', contact_first_name: 'Sebastián', contact_last_name: 'Delgado' },
	{email: 'maria@interwf.com', password: '12345678', role_id: 2, company_name: 'Interworld Freight', phone_number: '7862803736', outlook_password: 'Sdiwf**321', contact_first_name: 'Maria', contact_last_name: 'Dolores' },
	{email: 'juan@interwf.com', password: '12345678', role_id: 2, company_name: 'Interworld Freight', phone_number: '7862803736', outlook_password: 'Sdiwf**321', contact_first_name: 'Juanito', contact_last_name: 'Pérez' },
	{email: 'agent@agent.com', password: '12345678', role_id: 3 , company_name: 'Interworld Bogotá', phone_number: '7862803736', contact_first_name: 'J', contact_last_name: 'Balvin'},
	{email: 'agent1@agent.com', password: '12345678', role_id: 3 , company_name: 'Interworld Bogotá', phone_number: '7862803736', contact_first_name: 'Juan Luis', contact_last_name: 'Londoño'},
	{email: 'agent2@agent.com', password: '12345678', role_id: 3 , company_name: 'Interworld Bogotá', phone_number: '7862803736', contact_first_name: 'Carlos', contact_last_name: 'Vives'},
	{email: 'agent3@agent.com', password: '12345678', role_id: 3 , company_name: 'Interworld Bogotá', phone_number: '7862803736', contact_first_name: 'Juanes', contact_last_name: 'Aristizabal'},

	{email: 'shipper@shipper.com', password: '12345678', role_id: 4, company_name: 'Super Sipper', phone_number: '7862803736', contact_first_name: 'Camila', contact_last_name: 'Díaz'},
	{email: 'shippe1@shipper.com', password: '12345678', role_id: 4, company_name: 'Super Sipper', phone_number: '7862803736', contact_first_name: 'Pepita', contact_last_name: 'Chacón'},
	{email: 'shipper2@shipper.com', password: '12345678', role_id: 4, company_name: 'Super Sipper', phone_number: '7862803736', contact_first_name: 'Fulanita', contact_last_name: 'Pulido'},

	{email: 'pricing@pricing.com', password: '12345678', role_id: 7, company_name: 'IWF', phone_number: '7862803736'},
	{email: 'consignee@consignee.com', password: '12345678', role_id: 8, company_name: 'Consigneelandia', phone_number: '7862803736'},
	{email: 'naviera1@naviera.com', password: '12345678', role_id: 6, company_name: 'Hapag', phone_number: '7862803736', vendor_operation_mode: 'web', website: 'http://www.hapag.com'},
	{email: 'naviera2@naviera.com', password: '12345678', role_id: 6, company_name: 'Sealand- Maersk', phone_number: '7862803736', vendor_operation_mode: 'web', website: 'http://www.maersk.com'},
	{email: 'naviera3@naviera.com', password: '12345678', role_id: 6, company_name: 'CMA', phone_number: '7862803736', vendor_operation_mode: 'web', website: 'http://www.cma.com'},
	{email: 'naviera4@naviera.com', password: '12345678', role_id: 6, company_name: 'Crowley', phone_number: '7862803736', vendor_operation_mode: 'email'},
	{email: 'naviera5@naviera.com', password: '12345678', role_id: 6, company_name: 'Seaboard', phone_number: '7862803736', vendor_operation_mode: 'email'},
	{email: 'naviera6@naviera.com', password: '12345678', role_id: 6, company_name: 'MSC', phone_number: '7862803736', vendor_operation_mode: 'email'},
	{email: 'naviera7@naviera.com', password: '12345678', role_id: 6, company_name: 'Evergreen', phone_number: '7862803736', vendor_operation_mode: 'email'},
	{email: 'naviera8@naviera.com', password: '12345678', role_id: 6, company_name: 'King Ocean', phone_number: '7862803736', vendor_operation_mode: 'email'},
	{email: 'naviera9@naviera.com', password: '12345678', role_id: 6, company_name: 'One', phone_number: '7862803736', vendor_operation_mode: 'email'},
	{email: 'naviera10@naviera.com', password: '12345678', role_id: 6, company_name: 'Dole', phone_number: '7862803736', vendor_operation_mode: 'email'},
	{email: 'naviera11@naviera.com', password: '12345678', role_id: 6, company_name: 'APL', phone_number: '7862803736', vendor_operation_mode: 'email'},
	{email: 'naviera12@naviera.com', password: '12345678', role_id: 6, company_name: 'Antillean', phone_number: '7862803736', vendor_operation_mode: 'email'},
	{email: 'naviera13@naviera.com', password: '12345678', role_id: 6, company_name: 'Tropical', phone_number: '7862803736', vendor_operation_mode: 'email'},
	{email: 'naviera14@naviera.com', password: '12345678', role_id: 6, company_name: 'ECU', phone_number: '7862803736', vendor_operation_mode: 'email'},
	{email: 'naviera15@naviera.com', password: '12345678', role_id: 6, company_name: 'Shipco', phone_number: '7862803736', vendor_operation_mode: 'email'},
	{email: 'naviera16@naviera.com', password: '12345678', role_id: 6, company_name: 'Hamburg Sud', phone_number: '7862803736', vendor_operation_mode: 'email'}
])

Team.create(team_leader: 2)