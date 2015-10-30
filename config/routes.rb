Rails.application.routes.draw do

  root 'static_pages#home'

  get 'signup' => 'users#new'
  resources :users # add working /users/1 URL + work together with all the action needed for a s RESTful Users resource with large umber of named routes

end
