Rails.application.routes.draw do

#get 'sessions/new'

  root 'static_pages#home'

  get 'signup'      => 'users#new'

  get 'login'       => 'sessions#new' #Page for a new sessions(login)
  post 'login'      => 'sessions#create' #Create a new session(login)
  delete 'logout'   => 'sessions#destroy' #Delete a session (log out)

  resources :users # add working /users/1 URL + work together with all the action needed for a s RESTful Users resource with large number of named routes

end
