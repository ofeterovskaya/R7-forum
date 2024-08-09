Rails.application.routes.draw do
  get 'posts/create'
  get 'posts/new'
  get 'posts/edit'
  get 'posts/show'
  get 'posts/update'
  get 'posts/destroy'
  root 'forums#index'

  delete '/users/logoff', to: 'users#logoff', as: 'logoff_user'
  post '/users/:id/logon', to: 'users#logon', as: 'logon_user'

  # resources :users
  get '/users', to: 'users#index', as: 'users'
  get '/users/new', to: 'users#new', as: 'new_user'
  get '/users/:id', to: 'users#show', as: 'user'
  get '/users/:id/edit', to: 'users#edit', as: 'edit_user'
  post '/users', to: 'users#create'
  patch '/users/:id', to: 'users#update'
  delete '/users/:id', to: 'users#destroy'

  resources :forums do
    resources :posts, shallow: true, except: [:index]
    resources :subscriptions, shallow: true, except: [:index]
  end

  get '/subscriptions', 
  to: 'subscriptions#index', 
  as: 'subscriptions'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end