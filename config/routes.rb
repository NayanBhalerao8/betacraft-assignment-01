require "sidekiq/web"
require "sidekiq-scheduler/web"

Rails.application.routes.draw do

  root 'home#index'
  
  get "up" => "rails/health#show", as: :rails_health_check

  # API Routes
  namespace :api do
    namespace :v1 do
      resources :projects do
        resources :tasks, only: [:create, :update, :edit, :show]
        resources :comments, only: [:index, :create]
      end
    end
  end
  
  # Keep this route at the bottom
  get '*path', to: 'home#index', via: :all
end
