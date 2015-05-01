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
  end
  
  resources :users, only: [:create]
  resources :sessions, only: [:create]
end


