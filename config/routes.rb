# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :home, only: :index
      devise_for :users, path_names: {
                           sign_in: "login",
                           sign_out: "logout",
                           registration: "signup"
                         },
                         controllers: {
                           sessions: "api/v1/users/sessions",
                           registrations: "api/v1/users/registrations"
                         }
    end
  end

  namespace :session_store_api do
    namespace :v1 do
      resources :home, only: :index

      namespace :users do
        resources :sessions, only: [] do
          collection do
            post "login"
            delete "logout"
          end
        end
      end
    end
  end
end
