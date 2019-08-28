Rails.application.routes.draw do	

	devise_for :users, controllers: {
		sessions: 'users/sessions',
		registrations: 'users/registrations',
		passwords: 'users/passwords'
		}

	devise_scope :user do
		authenticated :user do
			root 'static_pages#home', as: :authenticated_root
		end

		unauthenticated do
			root 'devise/sessions#new', as: :unauthenticated_root
		end
	end
  
  resources :real_estates
  resources :investor_profiles, only: [:edit, :update]

end
