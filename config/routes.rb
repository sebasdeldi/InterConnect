Rails.application.routes.draw do

  resources :user_imports

	resources :operations_by_users, only: [:new, :create]
	resources :general_cargo_infos, only: [:new, :create]
	resources :fcl_exw_cargo_infos, only: [:new, :create]
	resources :operations, only: [:show]
	post "/fcl_exw_info", to: "fcl_exw_cargo_infos#request_info"
	post "/fcl_exw_confirm_info", to: "fcl_exw_cargo_infos#confirm_info"
	post "/fcl_exw_confirm_quotation", to: "fcl_exw_cargo_infos#confirm_quotation"
	get '/admin', to: "admins#index", as: "admin"
	match "/admin/general_charts", to: "general_charts#index", as: "general_charts", via: [:get, :post]
	match "/admin/general_records", to: "general_records#index", as: "general_records", via: [:get, :post]

	match "/admin/customers_charts", to: "customers_charts#index", as: "customers_charts", via: [:get, :post]
	match "/admin/customers_records", to: "customers_records#index", as: "customers_records", via: [:get, :post]

	match "/admin/representatives_charts", to: "representatives_charts#index", as: "representatives_charts", via: [:get, :post]
	match "/admin/representatives_records", to: "representatives_records#index", as: "representatives_records", via: [:get, :post]

	match "/representative", to: "representatives#index", as: "representative", via: [:get, :post]

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
