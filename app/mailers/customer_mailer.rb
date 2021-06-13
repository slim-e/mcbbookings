# frozen_string_literal: true

class CustomerMailer < ApplicationMailer
  def order_confirmation(order_id)
    @order = Order.find(order_id)
    mail to: @order.email, subject: "Récapitulatif de votre commande chez Mma Camp Brazil"
  end
end
