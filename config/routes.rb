Rails.application.routes.draw do

  resources :wikis

  root 'users#home'

  get '/auth/google_oauth2/callback', to: 'users#callback'
  delete 'logout', to: 'users#delete'

  resources :stars, only: :index do
    collection do
      post 'star',    to: 'stars#star'
      post 'unstar',  to: 'stars#unstar'
    end
  end

  get '/search', to: 'wikis#search'

  get '/upload_token', to: 'users#upload'

end
