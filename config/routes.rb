Rails.application.routes.draw do
  devise_for :users, skip: :registrations
  
  root "static_pages#home"
  get "help" => "static_pages#help"
  get "about" => "static_pages#about"

  resources :users, only: :show

  namespace :admin do
    root "users#index"
    resources :users
  end
end
