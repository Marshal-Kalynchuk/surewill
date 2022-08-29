Rails.application.routes.draw do
  resources :belongings
  
  root to: 'pages#home'

  devise_for :users, controllers: { sessions: "users/sessions" }

  devise_scope :user do
    get "active", to: "users/sessions#active"
    get "timeout", to: "users/sessions#timeout"
  end

  get 'billing', to: 'billing#show'

  # get '/wills/new', to: 'wills#new'
  resources :users, only: :show do

    resource :billing_account

    resource :will, except: :index do 
      
      get 'last_will_and_testament', to: 'wills#last_will_and_testament'
      

      resources :bequests, only: [], param: :index do
        member do
          delete '(:id)', to: 'bequests#destroy', as: ""
          post ':/' => "bequests#create"
        end
      end
      
      resources :build, controller: 'wills/build'
      resource :testator
      resources :delegates
      resources :properties
              
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
  get 'contact', to: 'pages#contact'
  get 'security', to: 'pages#security'
  get 'privacy', to: 'pages#privacy'
  get 'privacy_policy', to: 'pages#privacy_policy'
  get 'pricing', to: 'pages#pricing'
  get 'help', to: 'pages#help'

  get '/404', to: 'errors#not_found', as: 'not_found'
  get '/500', to: 'errors#internal_server', as: 'internal_server'
  get '/422', to: 'errors#unprocessable', as: 'unprocessable'

end
