# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

roles = Role.create!([{name: 'admin'},{name: 'representative'},{name: 'agent'},{name: 'customer'},{name: 'vendor'},{name: 'carrier'}])

users = User.create!([{email: 'admin@admin.com', password: '12345678', role_id: 1, company_name: 'Interworld Freight'},{email: 'representative@representative.com', password: '12345678', role_id: 2, company_name: 'Interworld Freight'},
	{email: 'agent@agent.com', password: '12345678', role_id: 3 , company_name: 'Interworld Bogotá'},{email: 'shipper@shipper.com', password: '12345678', role_id: 4, company_name: 'Super Sipper'},{email: 'naviera@naviera.com', password: '12345678', role_id: 5, company_name: 'Super Naviera'},
	{email: 'carrier@carrier.com', password: '12345678', role_id: 6, company_name: 'Super Carrier'}])

