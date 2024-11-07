require "sidekiq/web"
require "sidekiq-scheduler/web"

Rails.application.routes.draw do

  root 'home#index'
  
  get "up" => "rails/health#show", as: :rails_health_check

  # API Routes
  namespace :api do
    namespace :v1 do
      resources :projects, only: [:show] do
        resources :tasks, only: [:create, :update, :edit, :show] do
          resources :comments, only: [:index, :create]  # Nested under tasks
        end
      end
    end
  end
  
  # Keep this route at the bottom
  get '*path', to: 'home#index', via: :all
end
