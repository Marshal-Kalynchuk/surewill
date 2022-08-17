Rails.application.routes.draw do
  resources :assets

  root to: 'pages#home'

  devise_for :users

  get 'billing', to: 'billing#show'

  # get '/wills/new', to: 'wills#new'
  resources :users, only: :show do

    resource :billing_account

    resource :will, except: :index do 

      resources :build, controller: 'wills/build'
      resources :delegates
      resources :assets
      # put 'release', to: 'wills#release'

      # get 'access', to: 'access_payment#show'
      # get 'access/success', to: 'access_payment#success'

      get 'prepay', to: 'prepay_payment#show'
      get 'prepay/success', to: 'prepay_payment#success'

      # resource :biometric, only: :show do
      # 
      #   get 'payment', to: 'biometric_payment#show'
      #   get 'payment/success', to: 'biometric_payment#success'

      # end
    end
  end

  get 'home', to: 'pages#home'
  get 'about', to: 'pages#about'

  get '/404', to: 'errors#not_found', as: 'not_found'
  get '/500', to: 'errors#internal_server', as: 'internal_server'
  get '/422', to: 'errors#unprocessable', as: 'unprocessable'

end
