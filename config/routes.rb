Rails.application.routes.draw do
  get '/logout', to: 'sessions#destroy'
  get '/login', to: 'sessions#new'
  get '/auth/:provider/disable', to: 'users#disable_provider'
  post '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#failure'
  resources :sessions
  resources :memberships

  resources :users

  resources :feeds do
    resources :entries
  end

  root to: 'feeds#index'
end
