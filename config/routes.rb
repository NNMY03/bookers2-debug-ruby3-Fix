Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  
  root to: "homes#top"
  get "home/about" => "homes#about"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update] do
    resources :relationships, only: [:create, :destroy]
    get 'giv_followed' => 'relationships#giv_followed', as: 'giv_followed'
    get 'take_follower' =>'relationships#take_follower', as: 'take_follower'
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
 end
