Rails.application.routes.draw do
  root "static_pages#home"
  get "/signup", to: "users#new"
  get "/help", to: "static_pages#help"
  get "/contact", to: "static_pages#contact"
  get "/about", to: "static_pages#about"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :account_activations, only: :edit
  resources :password_resets, except: [:show, :delete]
  resources :microposts, only: [:create, :destroy]
  resources :users do
    member do
      get :following, to: "follow#following"
      get :followers, to: "follow#followers"
    end
  end
  resources :relationships, only: [:create, :destroy]
end
