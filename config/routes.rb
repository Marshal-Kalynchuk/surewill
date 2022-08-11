Rails.application.routes.draw do

  root to: 'pages#home'

  devise_for :users

  get 'billing', to: 'billing#show'
  
  # get '/wills/new', to: 'wills#new'
  resources :users, only: :show do

    resource :will do 

      put 'release', to: 'wills#release'

      get 'access', to: 'accessor#show'
      get 'access/success', to: 'accessor#success'

      get 'prepay', to: 'prepay#show'
      get 'prepay/success', to: 'prepay#success'
      
    end
  end

  resources :wills, only: :index

  
  get 'profile/edit', to: 'users#edit_profile', as: :edit_profile
  patch 'profile/update', to: 'users#update_profile', as: :update_profile

  get 'home', to: 'pages#home'
  get 'about', to: 'pages#about'

  get '/404', to: 'errors#not_found'
  get '/500', to: 'errors#internal_server'
  get '/422', to: 'errors#unprocessable'

end
