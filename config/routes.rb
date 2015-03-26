Rails.application.routes.draw do

  resources :wikis

  root 'users#home'

  get '/auth/google_oauth2/callback', to: 'users#callback'
  delete 'logout', to: 'users#delete'

  post 'star',    to: 'stars#star'
  post 'unstar',  to: 'stars#instar'

end
