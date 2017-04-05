Rails.application.routes.draw do
  get "/signup", to: "users#new"
  get "/help", to: "static_pages#help"
  get "/contact", to: "static_pages#contact"
  get "/about", to: "static_pages#about"
  resources :users
  root "static_pages#home"
end
