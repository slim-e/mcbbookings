# frozen_string_literal: true

class CheckoutController < ApplicationController
  def new
    @order = Order.find_by(id: params[:order_id].to_i)
  end

  def create
    # only if order not paid sinon redirect
    order = Order.find_by(id: params[:order_id].to_i)

    redirect_to root_path && return if order.nil?

    # Setting up Stripe session
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      line_items: [{
        name: "Commande : #{order.id}",
        description: order.stripe_order_name,
        amount: (order.total_amount * 100).round, # total amount in cents
        currency: "eur",
        quantity: 1
      }],
      success_url: checkout_success_url,
      cancel_url: checkout_cancel_url
    )

    respond_to do |format|
      format.js # render create.js.erb
    end
  end

  def success; end

end
