# frozen_string_literal: true

# == Route Map
#

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root "products#index"

  post "/webhook_events/:source", to: "webhook_events#create"

  scope "/checkout" do
    post "create", to: "checkout#create", as: "checkout_create"
    get "cancel", to: "checkout#cancel", as: "checkout_cancel"
    get "success", to: "checkout#success", as: "checkout_success"
  end

  get "carts/:id", to: "carts#show", as: "cart"
  delete "carts/:id", to: "carts#destroy"

  post "line_items/:id/add", to: "line_items#add_quantity", as: "line_item_add"
  post "line_items/:id/reduce", to: "line_items#reduce_quantity", as: "line_item_reduce"
  post "line_items", to: "line_items#create"
  get "line_items/:id", to: "line_items#show", as: "line_item"
  delete "line_items/:id", to: "line_items#destroy"

  resources :products, only: :index
  resources :orders, only: %i[new create] do
    get "new", to: "checkout#new", as: "checkout_new"
  end
end
