Rails.application.routes.draw do
  root "static_pages#home"
  get "/signup", to: "users#new"
  get "/help", to: "static_pages#help"
  get "/contact", to: "static_pages#contact"
  get "/about", to: "static_pages#about"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users
  resources :account_activations, only: :edit
  resources :password_resets, except: [:show, :delete]
  resources :microposts, only: [:create, :destroy]
end
