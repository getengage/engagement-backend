require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  namespace :admin do
    resources :users
    root to: "users#index"
  end

  constraints subdomain: "api" do
    scope module: "api", path: nil, defaults: {format: :json} do
      namespace :v1 do
        resources :reports, only: :create
      end
    end
  end

  unauthenticated do
    get "/pages/*id" => 'pages#show', as: :page, format: false
    root to: 'pages#show', id: 'home'
  end

  authenticated :user do
    namespace :dashboard do
      resources :events, only: [:index, :show] do
        resources :details, only: [:show, :index]
      end
      resources :settings, only: [:index]
      resources :reports, only: [:index]
      resource :main, only: :index
    end

    root to: "dashboard/main#index", as: :dashboard
  end

  devise_for :users
end
