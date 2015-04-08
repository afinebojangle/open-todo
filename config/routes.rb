Todo::Application.routes.draw do
  resources :users do 
    resources :lists, except: [:index]
  end

  resources :lists, only: [] do
    resources :items, only: [:create, :new]
  end

  resources :items, only: [:destroy]

  root to: 'users#new'
  
  namespace :api do
    post '/users/new', to: 'users#new'
    post '/lists/new', to: 'lists#new'
    post '/items/new', to: 'items#new'
    post '/users/auth', to: 'users#auth' 
    post '/lists/add', to: 'lists#add'
    post '/lists/remove', to: 'lists#remove'
    post '/lists/changepermissions', to: 'lists#changepermissions'
    post '/items/add', to: 'items#add'
    post '/items/remove', to: 'items#remove'
    post '/lists/index', to: 'lists#index'
  end
end
