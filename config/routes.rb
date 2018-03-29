Rails.application.routes.draw do

  resources :user_imports

	resources :operations_by_users, only: [:new, :create]
	resources :general_cargo_infos, only: [:new, :create]
	resources :operations, only: [:show]
 	
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
