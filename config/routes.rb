require "sidekiq/web"
require "sidekiq-scheduler/web"

Rails.application.routes.draw do

  root to: 'home#index', defaults: { format: :html }
  
  get "up" => "rails/health#show", as: :rails_health_check

  # config/routes.rb
  # devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # API Routes
  namespace :api do
    namespace :v1 do
      resources :projects, only: [:index, :show, :create] do
        resources :tasks, only: [:create, :update, :edit, :show, :index] do
          resources :comments, only: [:index, :create, :update, :edit, :show]  # Nested under tasks
        end
      end
    end
  end
  
  
  namespace :api do
    namespace :v1 do
      resources :projects do
        resources :invites, only: [:create] do
          member do
            post :accept
            post :reject
          end
        end
      end
    end
  end

  namespace :api do
    namespace :v1 do
      # Route for checking invites doesn't require a project ID
      get 'check_invites', to: 'invites#check_invites'
    end
  end
  
  
  
  # Keep this route at the bottom
  get '*path', to: 'home#index', via: :all
end
