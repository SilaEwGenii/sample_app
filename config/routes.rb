Rails.application.routes.draw do
  
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  #get 'static_pages/help'
  get '/about', to: 'static_pages#about'
  #get 'static_pages/about'
  get '/contact', to: 'static_pages#contact'
  #get 'static_pages/contact'
  get '/signup', to: 'users#new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users do
    member do
      get :following, :followers
    end
  end


  
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :update, :edit]
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
end
