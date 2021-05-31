# frozen_string_literal: true

class AdminMailer < ApplicationMailer
  def new_order_notification(order_id)
    @order = Order.find(order_id)
    mail to: "resa@mmcampbrazil.com", subject: "[MCB] Nouvelle commande!"
  end
end
