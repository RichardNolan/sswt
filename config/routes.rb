Rails.application.routes.draw do
  
  devise_for :admins
  devise_for :producers
  devise_for :customers
  
  get '/about',   to: 'about#index', :as => "about"
  get '/signup',  to: 'signup#index',:as => "signup"
    
  get '/products/:id/like',    to: 'products#like', as: 'like'

  resources :orders
  resources :order_items
  resources :hampers
  resources :hamper_items
  resources :product_likes
  resources :customers
  resources :counties
  resources :producer_images
  resources :categories
  resources :product_categories
  resources :product_images
  resources :producers
  
  resources :products
  

  root 'welcome#index'

  get '/customer/signup',    to: 'customers#new'
  post '/customer/signup',   to: 'customers#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
