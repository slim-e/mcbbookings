# frozen_string_literal: true

class CustomerMailer < ApplicationMailer
  def order_confirmation(order_id)
    @order = Order.find(order_id)
    mail to: @order.email, subject: "Récapitulatif de votre commande chez Mma Camp Brazil"
  end

  def send_contract(order_id)
    @order = Order.find(order_id)

    camp_durations = @order.products.pluck(:duration_in_days)
    @contract_url =
      if camp_durations.includes?(92)
        "https://drive.google.com/file/d/1Z0IkUAvUqBFoq-1yIY2xhSSS38TPf7zP/view?usp=sharing"
      elsif camp_durations.includes?(31)
        "https://drive.google.com/file/d/15ndh4eVY0B4JJtpyAcQGrr98niqcJ5uo/view?usp=sharing"
      else
        "https://drive.google.com/file/d/1szHSYIm0mm0xwn2JkI5ytLJQuP0LnYHd/view?usp=sharing"
      end

    mail to: @order.email, subject: "Dernière étape pour valider votre séjour au MMA Camp Brazil."
  end

  def faq(order_id)
    @order = Order.find(order_id)
    mail to: @order.email, subject: "Foire aux questions - MMA Camp Brazil"
  end
end
