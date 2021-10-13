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

  get 'following' => 'users#show_follow'
  get 'followers' => 'users#show_follower'

end