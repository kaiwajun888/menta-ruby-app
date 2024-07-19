Rails.application.routes.draw do
  root "posts#index"
  resources :posts, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :sessions, only: [:new, :create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
  delete 'logout', to: 'sessions#destroy', as: :logout
end
