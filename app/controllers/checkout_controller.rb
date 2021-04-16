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
      success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: checkout_cancel_url
    )

    respond_to do |format|
      format.js # render create.js.erb
    end
  end

  def success
    return root_path unless params[:session_id].present?

    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    @customer = Stripe::Customer.retrieve(@session.customer)

    order_id = @session.display_items.first.custom.name.split('Commande : ').last.to_i
    order = Order.find_by(id: order_id)

    order.update!(
      email: @customer.email,
      stripe_customer_id: @customer.id,
      stripe_payment_intent_id: @payment_intent.id,
      stripe_checkout_session_id: @session.id,
      paid: true,
      pay_method: 'card'
    )
  end

  def cancel; end
end
