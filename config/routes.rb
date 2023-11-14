require "sidekiq/web"

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"

  devise_for :users
  resources :assignments
  #get 'home/index'
  get 'home/about'
  # root 'home#index'
  root 'projects#index'

  resources :projects do
    resources :assignments, only: [:index]
  end

  resources :assignments do
    resources :comments
  end

  resources :comments

end
