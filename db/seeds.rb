# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

roles = Role.create!([{name: 'admin'},{name: 'agent'},{name: 'shipper'},{name: 'consignee'}])

users = User.create!([{email: 'admin@admin.com', password: '12345678', role_id: 1},{email: 'agent@agent.com', password: '12345678', role_id: 2},
	{email: 'shipper@shipper.com', password: '12345678', role_id: 3},{email: 'consignee@consignee.com', password: '12345678', role_id: 4}])

