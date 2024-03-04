Rails.application.routes.draw do
  resources :tasks
  root 'tasks#index'
  get '/auth/:provider/callback', to: 'auth_identities#create'
  delete '/sign_out', to: 'auth_identities#destroy'

  mount Karafka::Web::App, at: '/karafka'
end
