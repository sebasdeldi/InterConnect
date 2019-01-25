FactoryBot.define do
 	# Creating Roles
 	factory :admin_role, class: Users::Role do
 		name {'admin'}
 	end

 	factory :representative_role, class: Users::Role do
 		name {'representative'}
 	end

 	factory :agent_role, class: Users::Role do
 		name {'agent'}
 	end

 	factory :shipper_role, class: Users::Role do
 		name {'shipper'}
 	end

 	factory :vendor_role, class: Users::Role do
 		name {'vendor'}
 	end

 	factory :carrier_role, class: Users::Role do
 		name {'carrier'}
 	end

 	factory :pricing_representative_role, class: Users::Role do
 		name {'pricing_representative'}
 	end

 	factory :consignee_role, class: Users::Role do
 		name {'consignee'}
 	end

 	factory :pricing_role, class: Users::Role do
 		name {'pricing'}
 	end

 	factory :team_leader_role, class: Users::Role do
 		name {'team_leader'}
 	end
 	 
  # Create admin
  factory :admin, class: User do
    sequence(:email) { |n| "admin#{n}@interwf.com" }
  	password {'12345678'}
  	role_id :admin_role 
    company_name {'Interworld Freight'}
    phone_number {'3123213412'}
    contact_first_name {'Daniel'} 
    contact_last_name {'Zapata'}
  end

  # Create representative
  factory :representative, class: User do
    sequence(:email) { |n| "repre#{n}@interwf.com" }
  	password {'12345678'}
  	role_id :representative_role 
    company_name {'Interworld Freight'}
    phone_number {'3123213412'}
    contact_first_name {'Juan'} 
    contact_last_name {'Barreiro'}
  end

  # Create agent
  factory :agent, class: User do
    sequence(:email) { |n| "agent#{n}@agent.com" }
  	password {'12345678'}
  	role_id :agent_role 
    company_name {'Agent Company'}
    phone_number {'3123213412'}
    contact_first_name {'Camilo'} 
    contact_last_name {'Díaz'}
  end

  # Create shipper
  factory :shipper, class: User do
    sequence(:email) { |n| "shipper#{n}@shipper.com" }
  	password {'12345678'}
  	role_id :shipper_role 
    company_name {'Shipper Company'}
    phone_number {'3123213412'}
    contact_first_name {'Juan'} 
    contact_last_name {'Mosquera'}
  end

  # Create consignee
  factory :consignee, class: User do
    sequence(:email) { |n| "consignee#{n}@consignee.com" }
    password {'12345678'}
    role_id :consignee_role 
    company_name {'Consignee Company'}
    phone_number {'3123213412'}
    contact_first_name {'Pepo'} 
    contact_last_name {'Barreiro'}
  end

  # Create team leader
  factory :team_leader, class: User do
    sequence(:email) { |n| "tleader#{n}@interwf.com" }
  	password {'12345678'}
  	role_id :team_leader_role 
    company_name {'Interworld Freight'}
    phone_number {'3123213412'}
    contact_first_name {'Laura'} 
    contact_last_name {'Fontalvo'}
  end

  # Create Operations
  factory :operation, class: Operation do
    modality 'FCL-EXW'
    pol "Albania, Durres (Durazzo), AL DRZ"
    pod "Algeria, Ghazaouet, DZ GHA" 
    origin_address "calle 15"
    origin_zip_code "33126" 
    origin_city "Miami" 
    origin_state "FL" 
    origin_country "USA"
  end
end

