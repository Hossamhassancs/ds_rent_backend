Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      resources :brands, only: [:index]
      resources :cars, only: [:index, :show]
      resources :reservations, only: [:create]
      get 'lookup/transmission_en', to: 'lookup#transmission_en'
      get 'lookup/fuel_type_en', to: 'lookup#fuel_type_en'
      get 'lookup/car_type_en', to: 'lookup#car_type_en'
      get 'lookup/years', to: 'lookup#years'
      get 'lookup/num_of_seats', to: 'lookup#num_of_seats'
    end
  end

  


  # Defines the root path route ("/")
  # root "posts#index"
end
