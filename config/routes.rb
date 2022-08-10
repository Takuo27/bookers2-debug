Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get '/search', to: 'searches#search'
  get 'relationships/create'
  get 'relationships/destory'
  get 'book_comments/create'
  get 'book_comments/destroy'
  get 'favorites/create'
  get 'favorites/destroy'
  
  get 'chat/:id' => 'chats#show', as: 'chat'
  resources :chats, only: [:create, :show]
  
  resources :groups do
      get "join" => "groups#join"
  end
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
   
   resource :favorites, only: [:create, :destroy]
   resources :book_comments, only: [:create, :destroy]
  end
  
  
  resources :users, only: [:index,:show,:edit,:update] do
       get "daily_posts" => "users#daily_posts"
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
  end
  
  
  
 get 'home/about' => 'homes#about', as:"about"
  
end
