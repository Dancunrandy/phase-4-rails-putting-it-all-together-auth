Rails.application.routes.draw do
  resources :recipes, only: [:index, :create]
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
