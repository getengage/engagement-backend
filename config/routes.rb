Rails.application.routes.draw do
  namespace :admin do
    resources :users
    root to: "users#index"
  end
  devise_for :users
end
