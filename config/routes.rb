Koguchi::Application.routes.draw do
  root "static#home"
  devise_for :users
  resources :users
  resources :keys
  resources :sessions
  devise_scope :user do 
    match '/sessions/user', to: 'devise/sessions#create', via: :post
  end
end
