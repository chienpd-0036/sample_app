Rails.application.routes.draw do
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  root "static_pages#home"

  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users
  resources :account_activations, only: :edit
  resources :password_resets, except: %i(index show destroy)
  resources :microposts, only: %i(create destroy)
end
