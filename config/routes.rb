Myflix::Application.routes.draw do
  root to: "pages#front"
  get 'home', to:"videos#index"

  get 'sign_in', to: 'sessions#new'
  get 'sign_out', to: 'sessions#destroy'
  get 'ui(/:action)', controller: 'ui'
  get 'register', to: "users#new"

  resources :videos, only: [:show] do
    collection do
      get :search, to: "videos#search"
    end
    resources :reviews, only: [:create]
  end
  get 'my_queue', to:'queue_items#index'
  
  resources :users, only: [:create]
  resources :sessions, only: [:create]
  resources :categories, only: [:show]
  resources :queue_items, only: [:create , :destroy]
end


