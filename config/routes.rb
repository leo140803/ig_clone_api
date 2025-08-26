Rails.application.routes.draw do
  namespace :api do
  namespace :v1 do
  match 'health', to: 'health#show', via: [:get, :head]
  post 'auth/signup', to: 'auth#signup'
  post 'auth/login', to: 'auth#login'
  
  
  get 'users/me', to: 'users#me'
  get 'users/:username', to: 'users#show'
  patch 'users', to: 'users#update'
  get 'search/users', to: 'users#search'
  
  
  post 'users/:user_id/follow', to: 'follows#create'
  delete 'users/:user_id/follow', to: 'follows#destroy'
  get 'users/:user_id/followers', to: 'follows#followers'
  get 'users/:user_id/following', to: 'follows#following'
  
  
  resources :posts, only: %i[index create show destroy] do
  resources :comments, only: %i[index create]
  resource :like, only: %i[create destroy], controller: 'likes'
  end
  resources :comments, only: %i[destroy] do
  resource :like, only: %i[create destroy], controller: 'likes'
  end
  
  
  get 'feed', to: 'feed#index'
  

  
  resources :notifications, only: %i[index] do
  member do
  patch :mark_read
  end
  end
  end
  end
  end