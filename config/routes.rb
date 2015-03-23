Rails.application.routes.draw do

  mount Precious::App, at: 'wiki'

  root 'user#home'

  get '/auth/google_oauth2/callback', to: 'user#callback'
end
