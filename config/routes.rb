Rails.application.routes.draw do

  devise_for :users
  resources :users, :only => [:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'events#index'

  resources :events
  resources :static_pages
  resources :charges

  
end
