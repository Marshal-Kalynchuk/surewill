Rails.application.routes.draw do
  devise_for :users

  root to: 'pages#home'
  get 'home', to: 'pages#home', as: 'home'
  get 'about', to: 'pages#about', as: 'about'

  get 'billing', to: 'billing#show'
  get 'prepay', to: 'prepay#show'
  get 'prepay/success', to: 'prepay#success'

  # get '/wills/new', to: 'wills#new'
  resources :users do
    resources :wills do 

      get 'access', to: 'access#show'
      get 'access/success', to: 'access#success'
      
    end
  end
  put 'users/:user_id/wills/:id/release', to: 'wills#release', as: 'release_user_will'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
