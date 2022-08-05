Rails.application.routes.draw do
  devise_for :users
  
  resources :users

  #resources :subscriptions
  root to: 'home#index'
  resources :wills
    
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
