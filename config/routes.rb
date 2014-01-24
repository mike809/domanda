Questiona::Application.routes.draw do
  
  # Search
  post '/search',            :to => 'searches#create',     :as => 'search' 
  get  '/results/:keywords', :to => 'searches#index',      :as => 'results'

  # Session
  get    '/login',  :to => 'sessions#new',        :as => 'login'
  post   '/login',  :to => 'sessions#create',     :as => 'login'
  delete '/logout', :to => 'sessions#destroy',    :as => 'logout'

  # Static Pages
  root              :to => 'static_pages#home',   :as => 'home'
  match '/help',    :to => 'static_pages#help'
  match '/about',   :to => 'static_pages#about'
  match '/contact', :to => 'static_pages#contact' 

  # User
  get   '/signup',  :to => 'users#new',           :as => 'signup'
  post  '/signup',  :to => 'users#create',        :as => 'signup'
    
  resources :users, :only => [:show, :update, :edit], :path => '/' do
    # Questions
    resources :questions, :only => [:show, :index] do
      resources :answers, :only => [:create, :update, :destoy]
    end
    resources   :answers, :only => :index 
    # Follow
    get '/follows/:bool', :to => 'followers#index', :as => 'follows'
  end 
  
  resources :answers,   :only => :show
  resources :questions, :only => [:create, :update, :destroy, :edit]

  # Follow
  post   '/:id',    :to => 'followers#create',    :as => 'follow'
  delete '/:id',    :to => 'followers#destroy',   :as => 'unfollow'

  # Votes
  post   '/:id/upvote', :to => 'answers#upvote'
  post   '/:id/downvote', :to => 'answers#downvote'
end
