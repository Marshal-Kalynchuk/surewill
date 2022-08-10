Rails.application.routes.draw do
  devise_for :users

  root to: 'home#index'

  # get '/wills/new', to: 'wills#new'
  resources :users do
    resources :wills do 
      resources :subscriptions
    end
  end
  put 'users/:user_id/wills/:id/release', to: 'wills#release', as: 'release_user_will'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
