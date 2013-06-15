Thanksnote::Application.routes.draw do
  root 'sessions#show'
  get '/auth/failure' => 'sessions#show'
  get '/auth/:provider/callback' => 'sessions#create'
  get 'logout' => 'sessions#destroy'
end
