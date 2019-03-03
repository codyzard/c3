Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get  'static_pages/home', to: "static_pages#home" # get ->  to  lay view
  get  'static_pages/help'
    get  'static_pages/about'
    get 'static_pages/contact'

  # root 'application#hello'
   root 'static_pages#home'
end
