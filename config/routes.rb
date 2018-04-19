Rails.application.routes.draw do

  resources :user_imports

	resources :operations_by_users, only: [:new, :create]
	resources :general_cargo_infos, only: [:new, :create]
	resources :fcl_exw_cargo_infos, only: [:new, :create]
	resources :operations, only: [:show]
	post "/fcl_exw_info", to: "fcl_exw_cargo_infos#request_info"
	post "/fcl_exw_confirm_info", to: "fcl_exw_cargo_infos#confirm_info"


 	devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_scope :user do
	  authenticated :user do
	    root 'home#index', as: :authenticated_root
	  end

	  unauthenticated do
	    root 'devise/sessions#new', as: :unauthenticated_root
	  end
	end
end
