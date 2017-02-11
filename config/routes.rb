require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  namespace :admin do
    resources :users
    root to: "users#index"
  end

  # constraints subdomain: "api" do
    scope module: "api", path: nil, defaults: {format: :json} do
      namespace :v1 do
        resources :metrics, only: :create
        resources :api_keys, only: [:create, :destroy], param: :uuid
        resources :users, only: :update
      end
    end
  # end

  unauthenticated do
    get "/pages/*id" => 'pages#show', as: :page, format: false
    root to: 'pages#show', id: 'home'
  end

  authenticated :user do
    namespace :dashboard do
      resources :events, only: [:index, :show] do
        resources :details, only: [:show], param: :uuid
      end
      resources :settings, only: [:index]
      resources :reports, only: [:index, :create]
      resources :notifications, only: [:index]
      resources :insights, only: [:index]
      resource :main, only: :index
    end

    root to: "dashboard/main#index", as: :dashboard
  end

  devise_for :users
end
