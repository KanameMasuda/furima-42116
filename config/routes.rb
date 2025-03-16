Rails.application.routes.draw do
  root to: "items#index"
  get 'furima', to: 'items#index'
  resources :items
end
