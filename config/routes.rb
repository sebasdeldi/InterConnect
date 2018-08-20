Rails.application.routes.draw do


  get 'users_relationship/new/:representative_id', to: 'users_relationship#new', as: 'new_relationship'
  post 'users_relationship/create', as: 'create_relation'

  delete 'users_relationship/destroy', as: 'destroy_relation'
  get 'users_relationship/index_representatives', to: 'users_relationship#index_representatives', as: 'representatives_list'


  resources :user_imports

	resources :operations_by_users, only: [:new, :create]
	resources :general_cargo_infos, only: [:new, :create]
	resources :fcl_exw_cargo_info_steps, only: [:new, :create]
	resources :operations, only: [:show]
	post "/fcl_exw_info", to: "fcl_exw_cargo_info_steps#request_info"
	post "/fcl_exw_confirm_info", to: "fcl_exw_cargo_info_steps#confirm_info"
	post "/fcl_exw_confirm_quotation", to: "fcl_exw_cargo_info_steps#confirm_quotation"
	post "/fcl_exw_request_booking", to: "fcl_exw_cargo_info_steps#request_booking"
	get '/admin', to: "admins#index", as: "admin"
	post "/quotation/new/:secure_id", to: "fcl_exw_quotation_confirmed_steps#update_pricing", as: "new_quotation"
	post '/quotation_representative/:id', to: "fcl_exw_quotation_confirmed_steps#update_representative", as: "repre_quotation"
	get  "/quotation/new/:secure_id", to: "fcl_exw_quotation_confirmed_steps#new", as: "new_quotation_view"

	
	match "/admin/general_charts", to: "general_charts#index", as: "general_charts", via: [:get, :post]
	match "/admin/general_records", to: "general_records#index", as: "general_records", via: [:get, :post]

	match "/admin/customers_charts", to: "customers_charts#index", as: "customers_charts", via: [:get, :post]
	match "/admin/customers_records", to: "customers_records#index", as: "customers_records", via: [:get, :post]

	match "/admin/representatives_charts", to: "representatives_charts#index", as: "representatives_charts", via: [:get, :post]
	match "/admin/representatives_records", to: "representatives_records#index", as: "representatives_records", via: [:get, :post]

	match "/representative", to: "representatives#index", as: "representative", via: [:get, :post]
	get "/tasks_panel", to: "tasks#index"
	get "/tasks/:id", to: "tasks#show", as: "task"
	post "/pieces_for_cargo_info", to: "pieces#pieces_for_cargo_info", as: "pieces_for_cargo_info"
	post "/tasks", to: "tasks#create", as: "tasks"
	post "/update_tasks", to: "tasks#update", as: "update_tasks"
	post "/carrier_info", to: "operations#carrier_info"

 	devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_scope :user do
	  authenticated :user do
	    root to: 'roots_selector#index', as: :authenticated_root
	  end

	  unauthenticated do
	    root 'devise/sessions#new', as: :unauthenticated_root
	  end
	end
end
