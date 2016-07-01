Rails.application.routes.draw do
  namespace :admin do
    resources :users
    root to: "users#index"
  end

  constraints subdomain: "example" do
    get '/', to: 'report#index'
    resource :report, only: :create
  end

  get "/pages/*id" => 'pages#show', as: :page, format: false
  root to: 'pages#show', id: 'home'

  devise_for :users
end
