Rails.application.routes.draw do

  root to: 'homes#top'
  get 'home/about' => 'homes#about'

  devise_for :users

  resources :books  do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :users, only: [:show,:index,:edit,:update]

  resources :relationships, only: [:create, :destroy]

  get 'following' => 'relationships#show_follow'
  get 'followers' => 'relationships#show_follower'

  get '/search' , to: 'searches#search'

  resources :chats, only: [:show, :create]

end