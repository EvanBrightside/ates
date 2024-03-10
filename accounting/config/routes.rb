Rails.application.routes.draw do
  resources :tasks
  resources :auth_identities, only: [:create, :destroy]
  resources :accounts, only: [:index, :show]
  resources :payments, only: [:index, :show]
  resources :wallets, only: [:index, :show]

  root 'tasks#index'
  get '/auth/:provider/callback', to: 'auth_identities#create'
  delete '/sign_out', to: 'auth_identities#destroy'

  mount Karafka::Web::App, at: '/karafka'
end
