Rails.application.routes.draw do

  get 'users/edit'





	resources :operations_by_users, only: [:new, :create, :edit, :update]
	resources :general_cargo_infos, only: [:new, :create]
	resources :operations, only: [:show]
	
	get '/admin', to: "admins#index", as: "admin"


	
	match "/admin/general_records", to: "general_records#index", as: "general_records", via: [:get, :post]

	match "/admin/customers_records", to: "customers_records#index", as: "customers_records", via: [:get, :post]

	match "/admin/representatives_records", to: "representatives_records#index", as: "representatives_records", via: [:get, :post]

	match "/representative", to: "representatives#index", as: "representative", via: [:get, :post]
	


	get "/tasks_panel", to: "tasks#index"
	get "/tasks/:id", to: "tasks#show", as: "task"
	post "/pieces_for_cargo_info", to: "pieces#pieces_for_cargo_info", as: "pieces_for_cargo_info"
	post "/tasks", to: "tasks#create", as: "tasks"
	post "/update_tasks", to: "tasks#update", as: "update_tasks"
	post "/carrier_info", to: "operations#carrier_info"

	namespace :documents do
		get "/booking_sheet/:operation_id", to: "booking_sheet#show", as: "booking_sheet"
		get "/slis/:operation_id", to: "sli#show", as: "sli"
		get "/slis/new/:secure_id", to: "sli#new", as: "new_sli"
		post "/slis/create/:secure_id", to: "sli#create", as: "create_sli"
		post "/slis/request_sli/:secure_id", to: "sli#request_sli", as: "request_sli"
		post "/slis/tariff_group", to: "sli#tariff_group", as: "tariff_group"
		get "/invoices/new/:secure_id", to: "invoice#new", as: "new_invoice"
		post "/invoices/create/:secure_id", to: "invoice#create", as: "create_invoice"
		post "/invoices/request_invoice/:secure_id", to: "invoice#request_invoice", as: "request_invoice"
		post "/documents_transfer/:operation_id", to: "documents_transfer#send_mail", as: 'send_documents'
		get 'insurance/new/:secure_id', to: 'insurance#new', as: 'insurance_form'
		get 'insurance/view_pdf/:secure_id', to: 'insurance#view_pdf', as: 'insurance_pdf'
		post 'insurance/create', to: 'insurance#create', as: 'insurance_create'
		post 'insurance/send_info/:operation_id', to: 'insurance#send_info', as: 'insurance_send_info'
	end

	namespace :fcl_exw_steps do 
		post "/confirm_loading", to: "container_loadings#confirm_loading", as: "confirm_loading"
		post "/confirm_delivery", to: "container_deliveries#confirm_delivery", as: "confirm_delivery"
		post "/info", to: "info_requested#request_info"
		post "/confirm_info", to: "info_confirmed#confirm_info"
		post "/confirm_quotation", to: "quotation_confirmed#confirm_quotation"
		post "/request_booking", to: "request_bookings#request_booking"
		resources :cargo_info, only: [:new, :create]
		resources :booking_info, only: [:new, :create]
		post "/quotation/new/:secure_id", to: "quotation_confirmed#update_pricing", as: "new_quotation"
		post '/quotation_representative/:id', to: "quotation_confirmed#update_representative", as: "repre_quotation"
		get  "/quotation/new/:secure_id", to: "quotation_confirmed#new", as: "new_quotation_view"
		post "/quotation_sell_prices", to: 'quotation_selling#confirm'
		get "/quotation_sell/:id", to: "quotation_selling#show", as: "quotation_sell"
	end

	namespace :charts do
		match "/admin/general_charts", to: "generals#index", as: "general", via: [:get, :post]
		match "/admin/customers_charts", to: "customers#index", as: "customers", via: [:get, :post]
		match "/admin/representatives_charts", to: "representatives#index", as: "representatives", via: [:get, :post]
	end




	post "/change_difficulty", to: "operations#change_difficulty", as: "change_difficulty"


	devise_for :users, controllers: {
		sessions: 'users/sessions',
		registrations: 'users/registrations'
	}
	namespace :users do	
		get 'relationship/new/:representative_id', to: 'relationships#new', as: 'new_relationship'
		post 'relationship/create', to: 'relationships#create' ,as: 'create_relationship'
		delete 'relationship/destroy', to: 'relationships#destroy' , as: 'destroy_relationship'
		get 'relationship/index_representatives', to: 'relationships#index_representatives', as: 'representatives_list'
		match "/team_leader", to: "teams#index", as: "team", via: [:get, :post]
		get "/team_leader/:id", to: "teams#show", as: "team_member"
		post "/team_leader/change_representative", to: "teams#change_representative", as: "change_representative"
	end



  get '/users/edit/:id', to: 'users#edit', as: 'user'
  patch '/users/edit/:id', to: 'users#update'


  devise_scope :user do
	  authenticated :user do
	    root to: 'roots_selector#index', as: :authenticated_root
	  end

	  unauthenticated do
	    root 'devise/sessions#new', as: :unauthenticated_root
	  end
	end
end
