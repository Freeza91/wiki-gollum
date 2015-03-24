Rails.application.routes.draw do

  # mount Precious::App, at: 'wiki'

  resources :wikis do
    collection do
      post 'preview'
    end
  end

  resources :articles
  
  root 'user#home'

  get '/auth/google_oauth2/callback', to: 'user#callback'

  mount Markitup::Rails::Engine, at: 'markitup', as: 'markitup'
end
