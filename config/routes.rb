Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  get 'furima', to: 'items#index'
  resources :items
end
