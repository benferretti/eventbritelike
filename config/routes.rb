Rails.application.routes.draw do

  get 'avatars/index'
  get 'avatars/show'
  get 'avatars/new'
  get 'avatars/create'
  get 'avatars/edit'
  get 'avatars/update'
  get 'avatars/destroy'
  devise_for :users
  resources :users, :only => [:show, :index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'events#index'

  resources :events
  resources :static_pages
  resources :charges

  resources :events do
    resources :attendances
  end

  resources :events, only: [:show] do
    resources :avatars, only: [:create]
  end


  get '/admins', to: 'admins#index'

  namespace :admin do
   
    resources :users, :events
  end
  get '/admin', to: 'admin#index'
  
  
end
