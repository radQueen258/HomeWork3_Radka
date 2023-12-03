require "sidekiq/web"

Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
  mount Sidekiq::Web => "/sidekiq"

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :projects, only: %i[index create]
    end
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :projects do
        resources :assignments, only: %i[index create]
      end
    end
  end

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
