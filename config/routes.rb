Rails.application.routes.draw do

  mount Precious::App, at: 'wiki'

  root 'user#home'
end
