Rails.application.routes.draw do
  namespace :admin do
    resources :users
    root to: "users#index"
  end

  # constraints subdomain: "api" do
    scope module: "api", path: nil, defaults: {format: :json} do
      namespace :v1 do
        resources :reports, only: :create
      end
    end
  # end

  get "/pages/*id" => 'pages#show', as: :page, format: false
  root to: 'pages#show', id: 'home'

  devise_for :users
end
