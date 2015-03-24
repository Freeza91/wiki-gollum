Rails.application.routes.draw do

  mount Precious::App, at: 'wiki'

  resources :articles
  
  root 'user#home'

  get '/auth/google_oauth2/callback', to: 'user#callback'

  mount Markitup::Rails::Engine, at: 'markitup', as: 'markitup'
end
