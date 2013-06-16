Thanksnote::Application.routes.draw do
  root 'messages#index'
  get 'login' => 'sessions#show'
  get '/auth/failure' => 'sessions#show'
  get '/auth/:provider/callback' => 'sessions#create'
  get 'logout' => 'sessions#destroy'
  resources :messages, only: [:index, :new, :create]
end
