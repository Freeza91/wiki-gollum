Rails.application.routes.draw do

  # mount Precious::App, at: 'wiki'

  resources :wikis do
    collection do
      post 'preview'
    end
  end

  resources :articles

  root 'users#home'
  delete 'logout', to: 'users#delete'

  get '/auth/google_oauth2/callback', to: 'users#callback'

  mount Markitup::Rails::Engine, at: 'markitup', as: 'markitup'
end
