# frozen_string_literal: true

ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: "Dashboard"
end

ActiveAdmin.register Order do
  includes :line_items, :products
  menu priority: 2, label: "Commandes"
  actions :all, except: [:edit, :update, :destroy]
  permit_params :start_at

  sidebar "Détails de la commande", only: [:show] do
    ul do
      li link_to "Contenu du Panier (produits, quantité...)", admin_order_line_items_path(resource)
    end
  end

  index do
    selectable_column
    column 'Numéro', sortable: false do |order|
      link_to order.id, admin_order_path(order)
    end
    column 'Nom complet', sortable: false do |order|
      order.full_name
    end
    column 'Email', :email, sortable: false
    column 'Adresse', sortable: false do |order|
      order.full_address
    end
    column 'Début du stage', sortable: true  do |order|
      order.start_at.strftime("%d / %m / %Y")
    end
    column 'Fin du Stage', sortable: false do |order|
      order.end_at.strftime("%d / %m / %Y")
    end
    column 'Payé ?', :paid, sortable: false
    column 'Montant Total', sortable: false do |order|
      number_to_currency(order.total_amount, unit: "€", separator: ",", delimiter: "", format: "%n %u")
    end
    column 'Montant Encaissé', sortable: true  do |order|
      number_to_currency(order.discounted_amount, unit: "€", separator: ",", delimiter: "", format: "%n %u")
    end
    column 'Coupon', :coupon, sortable: false
    column 'Date de création', sortable: true do |order|
      order.created_at.strftime("%d / %m / %Y")
    end
  end
end

ActiveAdmin.register LineItem do
  belongs_to :order
  menu false
  actions :all, except: [:show, :edit, :update, :destroy]

  index do
    selectable_column
    column 'N° de Commande', sortable: false do |line_item|
      link_to line_item.order_id, admin_order_path(line_item.order)
    end
    column 'Produit', sortable: false do |line_item|
      link_to line_item.product.name, admin_product_path(line_item.product)
    end
    column 'Quantité', :quantity, sortable: false
    column 'Prix Unitaire', sortable: false do |line_item|
      number_to_currency(line_item.product.price, unit: "€", separator: ",", delimiter: "", format: "%n %u")
    end
    column 'Sous-Total', sortable: false do |line_item|
      number_to_currency(line_item.total_price, unit: "€", separator: ",", delimiter: "", format: "%n %u")
    end
    column 'Date de création', sortable: true do |line_item|
      line_item.created_at.strftime("%d / %m / %Y")
    end
  end
end

ActiveAdmin.register Product do
  menu priority: 3, label: "Produits"
  actions :all
  permit_params :name, :price, :duration_in_days

  index do
    selectable_column
    column 'Nom', sortable: false do |product|
      link_to product.name,  admin_product_path(product)
    end
    column 'Prix Unitaire', sortable: false do |product|
      number_to_currency(product.price, unit: "€", separator: ",", delimiter: "", format: "%n %u")
    end
    column 'Durée (en jours)', :duration_in_days, sortable: false
    column 'Date de création', sortable: true do |product|
      product.created_at.strftime("%d / %m / %Y")
    end
  end
end

ActiveAdmin.register Room do
  menu priority: 4, label: "Chambres"
  actions :all, except: [:show, :edit, :update, :destroy]

  index do
    selectable_column
    column 'Numéro', :number, sortable: false
    column 'Réservée ?', :booked, sortable: false
    column 'Date de création', sortable: true do |room|
      room.created_at.strftime("%d / %m / %Y")
    end
  end
end

ActiveAdmin.register Discount do
  menu priority: 5, label: "Coupons de réduction"
  actions :all, except: [:destroy]

  index do
    selectable_column
    column 'Nom', :name, sortable: false
    column 'Montant', :amount, sortable: false
    column 'Pourcentage', sortable: false do |discount|
      "-#{discount.percentage}%"
    end
    column 'Date de création', sortable: true do |order|
      order.created_at.strftime("%d / %m / %Y")
    end
  end
end

ActiveAdmin.register WebhookEvent do
  menu priority: 6, label: "Webhook Events (Stripe)"
  actions :all, except: [:create, :edit, :update, :destroy]
end
