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
  
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
   
   resource :favorites, only: [:create, :destroy]
   resources :book_comments, only: [:create, :destroy]
  end
  
  
  resources :users, only: [:index,:show,:edit,:update] do
       get "search", to: "users#search"
      resource :relationships, only: [:create, :destroy]
      member do 
           get :followings
           get :followers
       end
      
  end
  
  
  
 get 'home/about' => 'homes#about', as:"about"
  
end
