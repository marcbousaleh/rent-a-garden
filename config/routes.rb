Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :gardens, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    resources :bookings, only: [:new, :create]
    resources :reviews, only: :create
  end
  resources :bookings, only: [:index]
  get 'my_gardens', to: 'gardens#my_gardens'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
