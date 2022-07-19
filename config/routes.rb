Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destory'
  get 'book_comments/create'
  get 'book_comments/destroy'
  get 'favorites/create'
  get 'favorites/destroy'
  devise_for :users
  root to: 'homes#top'
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
   resource :favorites, only: [:create, :destroy]
   resources :book_comments, only: [:create, :destroy]
  end
  
  
  resources :users, only: [:index,:show,:edit,:update] do
      resource :relationships, only: [:create, :destroy]
      member do 
           get :followings
           get :followers
       end
      
  end
  
  
  
 get 'home/about' => 'homes#about', as:"about"
  
end
