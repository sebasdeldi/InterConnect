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
	{name: 'consignee'}
	])

users = User.create!([
	{email: 'admin@admin.com', password: '12345678', role_id: 1, company_name: 'Interworld Freight', phone_number: '7862803736'},
	{email: 'sdelgado@interwf.com', password: '12345678', role_id: 2, company_name: 'Interworld Freight', phone_number: '7862803736', outlook_password: 'Sdiwf**321' },
	{email: 'agent@agent.com', password: '12345678', role_id: 3 , company_name: 'Interworld Bogotá', phone_number: '7862803736'},
	{email: 'shipper@shipper.com', password: '12345678', role_id: 4, company_name: 'Super Sipper', phone_number: '7862803736'},
	{email: 'naviera@naviera.com', password: '12345678', role_id: 5, company_name: 'Super Naviera', phone_number: '7862803736'},
	{email: 'carrier@carrier.com', password: '12345678', role_id: 6, company_name: 'Super Carrier', phone_number: '7862803736'}, 
	{email: 'carrier2@carrier2.com', password: '12345678', role_id: 6, company_name: 'Super2 Carrier2', phone_number: '22222222222222'}, 
	{email: 'pricing@pricing.com', password: '12345678', role_id: 7, company_name: 'IWF', phone_number: '7862803736'},
	{email: 'consignee@consignee.com', password: '12345678', role_id: 8, company_name: 'Consigneelandia', phone_number: '7862803736'}
])

