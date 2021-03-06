Rails.application.routes.draw do

  # Root Page
  root 'welcome#index'
  
  get 'admins/sign_up', to: 'welcome#index'
  # Producer not allowed
  get 'producer/not_allowed', to: 'producers#not_allowed', as: 'producer_not_allowed'


  # Producer Products page
  get '/producers/:id/products', to: 'producers#products', as: 'producer_products'
  

  # Ajax Hamper Items
  get 'hampers/:id/hamper_items', to: 'hampers#hamper_items'

  # Ajax Order Items
  get 'orders/:id/order_items', to: 'orders#order_items'

  # Remove Hamper Item
  put '/hampers/:id/removeitem', to: 'hampers#delete_hamper_item'

  
  # Devise routes
  devise_for :admins#, :skip => [:registrations]
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
  post 'hamper_item/add',    to: 'hamper_items#add',   as: 'add_to_hamper'
  post 'hamper/empty',  to: 'hamper_items#empty', as: 'empty_hamper'
  post 'hamper/data',  to: 'hamper_items#get_hamper_data'
 
  post 'hamper/createhamper', to: 'hampers#create_hamper' 

  # dont allow default edit profile url
  get '/producers/:id/edit', to: 'producers#not_allowed'
  get '/customers/:id/edit', to: 'producers#not_allowed'

  get '/producer/orders',     to: 'producers#orders'

  get '/orders/verify', to: 'orders#verify'

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

  ##  QUESTION
  ##  SHOULD THESE BE ABOVE THE RESOURCES?

  # Disable Producer
  delete '/producers/:id', to: 'producers#destroy'

  # Enable Producer
  put '/producers/:id/enable', to: 'producers#enable', as: 'enable_producer'

  # Disable Customer
  delete '/customers/:id', to: 'customers#destroy'

  # Enable Customer
  put '/customers/:id/enable', to: 'customers#enable', as: 'enable_customer'

  # Disable Product
  put '/products/:id/disable', to: 'products#disable', as: 'disable_product'

  # Enable Product
  put '/products/:id/enable', to: 'products#enable', as: 'enable_product'

  # Un-delete Product
  put '/products/:id/undelete', to: 'products#undelete', as: 'undelete_product'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
