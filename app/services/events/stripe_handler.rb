# frozen_string_literal: true

module Events
  class StripeHandler
    def self.process(event)
      stripe_event = Stripe::Event.construct_from(event.data)

      case stripe_event.type
      when "checkout.session.completed"
        checkout_session = stripe_event.data.object

        # Find order in DB
        order_id = checkout_session.display_items.first.custom.name.split(" : ").last.to_i # Set in CheckoutController#create
        order = Order.find(order_id)

        if order.present?
          # Update order
          order.update({
                         email: checkout_session.customer_details.email,
                         stripe_checkout_session_id: checkout_session.id,
                         stripe_customer_id: checkout_session.customer,
                         stripe_payment_intent_id: checkout_session.payment_intent,
                         paid: checkout_session.payment_status == "paid",
                         pay_method: "card"
                       })

          # Notify customer by email
          CustomerMailer.order_confirmation(order_id).deliver_now # !
          CustomerMailer.send_contract(order_id).deliver_later(wait_until: 30.seconds.from_now)
          CustomerMailer.faq(order_id).deliver_later(wait_until: 1.day.from_now)
          CustomerMailer.keep_in_touch(order_id).deliver_later(wait_until: 7.days.from_now)

          # Notify admin by email
          AdminMailer.new_order_notification(order_id).deliver_now
        # else # Handle errors
        end
      end
    end
  end
end
