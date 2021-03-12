Rails.application.routes.draw do
  resources :room_payments
  resources :bookings
  resources :users
  resources :admins
  resources :clients
  resources :packages
  resources :rooms
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
