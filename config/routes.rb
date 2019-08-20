Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'payment-confirmation', to: 'pages#payment_confirmation'
  resources :gardens, only: [:index, :new, :create]
  resources :bookings, only: [:index, :new, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
