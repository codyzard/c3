Rails.application.routes.draw do
  get 'users/new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # root 'static_pages#home'
  # get  'static_pages/home', to: "static_pages#home" # get ->  to  lay view
  # get  'static_pages/help'
  # get  'static_pages/about'
  # get 'static_pages/contact

  root "static_pages#home"
 # resources :static_pages
  get  "/help",    to: "static_pages#help" #as: "helf"
  get  "/about",   to: "static_pages#about"
  get  "/contact", to: "static_pages#contact"
  get "/signup", to: "users#new"
end
