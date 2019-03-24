Rails.application.routes.draw do
  
  
  get 'password_resets/new'
  get 'password_resets/edit'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # root 'static_pages#home'
  # get  'static_pages/home', to: "static_pages#home" # get ->  to  lay view
  # get  'static_pages/help'
  # get  'static_pages/about'
  # get 'static_pages/contact


  #static_pages
  root "static_pages#home" #Home
  get  "/help",    to: "static_pages#help" #as: "helf"
  get  "/about",   to: "static_pages#about"
  get  "/contact", to: "static_pages#contact"


  #user
  resources :users
  get "/users", to: "users#index"
  get "/signup", to: "users#new"
  post "/signup",  to: "users#create"
  patch "/edit", to: "user#edit"
  
  
  #login session
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  #account_activation
  resources :account_activations, only: [:edit]

  #password reset
  resources :password_resets, only: [:new, :create, :edit, :update]
end
