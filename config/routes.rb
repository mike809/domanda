Questiona::Application.routes.draw do

  # Search
  post '/search',   :to => 'searches#create',     :as => 'search' 

  # Session
  get    '/login',  :to => 'sessions#new',     :as => 'login'
  post   '/login',  :to => 'sessions#create',     :as => 'login'
  delete '/logout', :to => 'sessions#destroy',    :as => 'logout'

  # Static Pages
  root              :to => 'static_pages#home',   :as => 'home'
  match '/help',    :to => 'static_pages#help'
  match '/about',   :to => 'static_pages#about'
  match '/contact', :to => 'static_pages#contact' 

  # User
  get   '/signup',  :to => 'users#new',           :as => 'signup'
  get   '/edit',    :to => 'users#edit',          :as => 'edit_user'
  post  '/signup',  :to => 'users#create'
  get   '/:id',     :to => 'users#show',          :as => 'user'
  put   '/:id',     :to => 'users#update'

end
