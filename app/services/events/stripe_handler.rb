# frozen_string_literal: true

module Events
  class StripeHandler
    def self.process(event)
      stripe_event = Stripe::Event.construct_from(event.data)

      case stripe_event.type
      when "checkout.session.completed"
        checkout_session = stripe_event.data.object

        order_id = checkout_session.display_items.first.custom.name.split(" : ").last.to_i
        order = Order.find(order_id)

        if order.present?
          order.update({
                         email: checkout_session.customer_details.email,
                         stripe_checkout_session_id: checkout_session.id,
                         stripe_customer_id: checkout_session.customer,
                         stripe_payment_intent_id: checkout_session.payment_intent,
                         paid: checkout_session.payment_status == "paid",
                         pay_method: "card"
                       })
        end
      end
    end
  end
end
