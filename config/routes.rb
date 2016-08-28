require 'sidekiq/web'

Rails.application.routes.draw do
  get 'hello_world', to: 'hello_world#index'
  mount Sidekiq::Web => '/sidekiq'

  # some constraints here
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
      resources :events, only: :show do
        resources :details, only: [:show, :index]
      end
      resource :main, only: :index
    end

    root to: "dashboard/main#index", as: :dashboard
  end

  devise_for :users
end
