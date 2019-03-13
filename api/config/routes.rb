Rails.application.routes.draw do
  resources :users, only: [:create, :show, :update]
  resources :games, only: [:create, :show, :update]
end
