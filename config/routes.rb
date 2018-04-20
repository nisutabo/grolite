Rails.application.routes.draw do
  resources :readings
  namespace :api do
    namespace :v1 do
      resources :tasks
      resources :groups, only: [:index, :show, :create, :update]
      resources :crops, only: [:index, :show, :create, :update]
      resources :readings, only: [:index, :show, :create, :destroy]
      resources :users, only: [:index, :show, :create, :update]
      post '/signup', to: 'users#create'
      post '/login', to: 'auth#create'
      get '/get_user', to: 'auth#show'
      get '/groups/:id/data', to: 'groups#data'
      get '/users/:id/groups', to: 'users#groups'
    end
  end
end
