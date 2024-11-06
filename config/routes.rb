require "sidekiq/web"
require "sidekiq-scheduler/web"

Rails.application.routes.draw do
  devise_for :users

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  authenticate :admin_user do
    mount Sidekiq::Web => '/sidekiq'
  end

  root 'home#index'
  
  get "up" => "rails/health#show", as: :rails_health_check

  # Keep this route at the bottom
  get '*path', to: 'home#index', via: :all
end
