Rails.application.routes.draw do
  root "tops#index"
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
  delete 'logout', to: 'sessions#destroy', as: :logout
end
