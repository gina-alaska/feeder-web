Rails.application.routes.draw do
  resources :slideshows do
    get :carousel, on: :member
    resources :entries, only: [:index]
  end

  resources :categories

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
    get :more_info
    
    resources :entries, shallow: true
    
    resources :slideshows, only: [:add, :remove] do
      member do
        get :add
        get :remove
      end
    end
  end
  
  resources :entries, only:[] do
    resource :highlights
  end

  get '/preview/*id(.:format)' => Dragonfly.app.endpoint { |params, app|
    image = Entry.where('preview_uid LIKE ?', "#{params[:id]}%").first.preview
    format = params[:format] || 'jpg'
    size = params[:size] || '500x500'

    begin
      unless image.image?
        image = app.fetch_file(Rails.root.join("app/assets/images/missing.jpg"))
      end
    rescue
      image = app.fetch_file(Rails.root.join("app/assets/images/missing.jpg"))
    end

    image = image.thumb(size)
    image = image.encode(format) if image.format.to_s != format
    image
  }, as: :entry_preview

  if Rails.env.development?
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end

  root to: 'feeds#index'
end
