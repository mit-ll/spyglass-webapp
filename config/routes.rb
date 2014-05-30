Koguchi::Application.routes.draw do
  root "static#home"
  devise_for :users
  resources :users
  resources :keys
  resources :sessions
end
