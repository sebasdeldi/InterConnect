# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

roles = Users::Role.create!([
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
	{email: 'dzapata@interwf.com', password: '12345678', role_id: 1, company_name: 'Interworld Freight', phone_number: '0', contact_first_name: 'Daniel', contact_last_name: 'Zapata'},
	{email: 'lfontalvo@interwf.com', password: '12345678', role_id: 10, company_name: 'Interworld Freight', phone_number: '0', contact_first_name: 'Laura', contact_last_name: 'Fontalvo'},
	{email: 'lcuesta@interwf.com', password: 'Say09916', role_id: 2, company_name: 'Interworld Freight', phone_number: '53435453', outlook_password: 'Say09916', contact_first_name: 'Laura', contact_last_name: 'Cuesta',
	address: '7741 nw 7th st', state: 'Florida', country: 'USA', city: 'Miami', zip_code: 33126 },
	{email: 'jbarreiro@interwf.com', password: 'Loh15672', role_id: 2, company_name: 'Interworld Freight', phone_number: '53435453', outlook_password: 'Say09916', contact_first_name: 'Laura', contact_last_name: 'Cuesta',
	address: '7741 nw 7th st', state: 'Florida', country: 'USA', city: 'Miami', zip_code: 33126 },
	{email: 'pricing@interwf.com', password: '12345678', role_id: 7, company_name: 'IWF', phone_number: '7862803736'},
	{email: 'carlos.melian@msc.com', password: '12345678', role_id: 6, company_name: 'MSC', phone_number: 'N/A', vendor_operation_mode: 'email', website: 'N/A'},
	{email: 'miguel.carpio@msc.com', password: '12345678', role_id: 6, company_name: 'MSC', phone_number: 'N/A', vendor_operation_mode: 'email', website: 'N/A'},
	{email: 'alejandro.cuervo@msc.com', password: '12345678', role_id: 6, company_name: 'MSC', phone_number: 'N/A', vendor_operation_mode: 'email', website: 'N/A'},
	{email: 'j.garcia@msc.com', password: '12345678', role_id: 6, company_name: 'MSC', phone_number: 'N/A', vendor_operation_mode: 'email', website: 'N/A'},
	{email: 'jax-newbkg@hamburgsud.com', password: '12345678', role_id: 6, company_name: 'HamburgSud', phone_number: 'N/A', vendor_operation_mode: 'email', website: 'N/A'},
	{email: 'marcela.garcia@msc.com', password: '12345678', role_id: 6, company_name: 'MSC', phone_number: 'N/A', vendor_operation_mode: 'email', website: 'N/A'},
	{email: 'carlos.romero@msc.com', password: '12345678', role_id: 6, company_name: 'MSC', phone_number: 'N/A', vendor_operation_mode: 'email', website: 'N/A'},
	{email: 'melissa.ochoa@msc.com', password: '12345678', role_id: 6, company_name: 'MSC', phone_number: 'N/A', vendor_operation_mode: 'email', website: 'N/A'},
	{email: 'victoria.nunes@msc.com', password: '12345678', role_id: 6, company_name: 'MSC', phone_number: 'N/A', vendor_operation_mode: 'email', website: 'N/A'},
	{email: 'christian.morris@msc.com', password: '12345678', role_id: 6, company_name: 'MSC', phone_number: 'N/A', vendor_operation_mode: 'email', website: 'N/A'},
	{email: 'wendy.perry@hamburgsud.com', password: '12345678', role_id: 6, company_name: 'HamburgSud', phone_number: 'N/A', vendor_operation_mode: 'email', website: 'N/A'},
	{email: 'mailbkg@evergreen.com.tw', password: '12345678', role_id: 6, company_name: 'Evergreen', phone_number: 'N/A', vendor_operation_mode: 'email', website: 'N/A'},
	{email: 'cscolombia@kingocean.com', password: '12345678', role_id: 6, company_name: 'King Ocean', phone_number: 'N/A', vendor_operation_mode: 'email', website: 'N/A'},
	{email: 'jose.cardona2@crowley.com', password: '12345678', role_id: 6, company_name: 'Crowley', phone_number: 'N/A', vendor_operation_mode: 'email', website: 'N/A'},
	{email: 'customercare@tropical.com', password: '12345678', role_id: 6, company_name: 'Tropical', phone_number: 'N/A', vendor_operation_mode: 'email', website: 'N/A'},
	{email: 'elizabeth.aleman@vanguardlogistics.com', password: '12345678', role_id: 6, company_name: 'Vanguard', phone_number: 'N/A', vendor_operation_mode: 'email', website: 'N/A'},
	{email: 'darmas@shipco.com', password: '12345678', role_id: 6, company_name: 'Shipco', phone_number: 'N/A', vendor_operation_mode: 'email', website: 'N/A'},
	{email: 'daliany.avila@msc.com', password: '12345678', role_id: 6, company_name: 'MSC', phone_number: 'N/A', vendor_operation_mode: 'email', website: 'N/A'},
	{email: 'carmen.mckinnon@hamburgsud.com', password: '12345678', role_id: 6, company_name: 'HamburgSud', phone_number: 'N/A', vendor_operation_mode: 'email', website: 'N/A'},
	{email: 'yolanda.bunn@hamburgsud.com', password: '12345678', role_id: 6, company_name: 'HamburgSud', phone_number: 'N/A', vendor_operation_mode: 'email', website: 'N/A'},
	{email: 'falvarenga@greatwhitefleet.com', password: '12345678', role_id: 6, company_name: 'GWF', phone_number: 'N/A', vendor_operation_mode: 'email', website: 'N/A'},
	{email: 'hilarykaganas@evergreen-shipping.us', password: '12345678', role_id: 6, company_name: 'Evergreen', phone_number: 'N/A', vendor_operation_mode: 'email', website: 'N/A'},
	{email: 'cssca@kingocean.com', password: '12345678', role_id: 6, company_name: 'King Ocean', phone_number: 'N/A', vendor_operation_mode: 'email', website: 'N/A'},
	{email: 'jesus.intriago@seaboardmarine.com', password: '12345678', role_id: 6, company_name: 'Seaboard', phone_number: 'N/A', vendor_operation_mode: 'email', website: 'N/A'},
	{email: 'carmen.alvarez@seaboardmarine.com', password: '12345678', role_id: 6, company_name: 'Seaboard', phone_number: 'N/A', vendor_operation_mode: 'email', website: 'N/A'},
	{email: 'bookingrequests@crowley.com', password: '12345678', role_id: 6, company_name: 'Crowley', phone_number: 'N/A', vendor_operation_mode: 'email', website: 'N/A'},
	{email: 'sealand@sealand.com', password: '12345678', role_id: 6, company_name: 'Sealand', phone_number: 'N/A', vendor_operation_mode: 'web', website: 'https://my.sealand.com/booking/new'},
	{email: 'hapag@hapag.com', password: '12345678', role_id: 6, company_name: 'Hapag', phone_number: 'N/A', vendor_operation_mode: 'web', website: 'https://www.hapag-lloyd.com/es/online-business/booking/list-of-requests.html'},
	{email: 'cma@cma.com', password: '12345678', role_id: 6, company_name: 'CMA', phone_number: 'N/A', vendor_operation_mode: 'web', website: 'https://www.cma-cgm.com/ebusiness/booking/request'}

])

Users::Team.create(team_leader: 2)