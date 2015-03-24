Rails.application.routes.draw do

  # mount Precious::App, at: 'wiki'

  resources :wikis do
    collection do
      post 'preview'
    end
  end

  root 'user#home'

  get '/auth/google_oauth2/callback', to: 'user#callback'
end
