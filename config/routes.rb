Rails.application.routes.draw do


  # Root Page
  root 'welcome#index'
  
  
  # Devise routes
  devise_for :admins
  devise_for :producers
  devise_for :customers


  # About Us Page
  get '/about',   to: 'about#index', :as => "about"
  
  # Page for choosing to sign up as Producer or Customer
  get '/signup',  to: 'signup#index',:as => "signup"

  # Products by Category
  get '/products/category/:id', to: 'categories#show'

  # Product search by keyword
  get '/products/search(/:query)', to: 'products#search'

  # product likes route
  get '/products/:id/like',    to: 'products#like', as: 'like'

  # session hamper add and empty
  post 'hamper/add',    to: 'hamper_items#add',   as: 'add_to_hamper'
  post 'hamper/empty',  to: 'hamper_items#empty', as: 'empty_hamper'

  get 'hampers_modal/', to: 'hampers#index', layout: 'modal'
  # Scaffold resources  
    
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


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
