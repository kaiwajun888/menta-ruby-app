Rails.application.routes.draw do
  root "tops#index"
  resources :users, only: [:new]
  resources :sessions, only: [:new]
end
