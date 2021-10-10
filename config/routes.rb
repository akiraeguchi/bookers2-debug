Rails.application.routes.draw do
  root to: 'homes#top'
  resources :users,only: [:show,:index,:edit,:update]
  resources :books
  devise_for :users
  
  get 'home/about' => 'homes#about'