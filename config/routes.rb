Rails.application.routes.draw do
  
  devise_for :admins
  devise_for :producers
  devise_for :customers
  
  # About Us Page
  get '/about',   to: 'about#index', :as => "about"
  
  # Page for choosing to sign up as Producer or Customer
  get '/signup',  to: 'signup#index',:as => "signup"

  # Products by Category
  get '/products/category/:id', to: 'categories#show'
  
  resources :orders
  resources :order_items
  resources :hampers
  resources :hamper_items
  resources :product_likes
  resources :customers
  resources :counties
  resources :producer_images
  resources :categories
  resources :product_images
  resources :producers
  resources :products
  
  # Root Page
  root 'welcome#index'

  #get '/customer/signup',    to: 'customers#new'
  #post '/customer/signup',   to: 'customers#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
