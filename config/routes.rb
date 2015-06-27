Rails.application.routes.draw do
  devise_for :users
  root "static_pages#home"
  get "help" => "static_pages#help"
  get "about" => "static_pages#about"

  resources :users do
    resource :skill_users
      get "add_skills" => "skill_users#show"
    end
  namespace :admin do
    root "users#index"
    resources :users
    resources :skills
    resources :positions
    resources :teams
  end
  resources :skills, only: :index
  resources :projects, only: :index
end
