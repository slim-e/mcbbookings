# frozen_string_literal: true

module Orders
  class DiscountCalculater
    attr_reader :order, :discount

    def initialize(order)
      @order = order
      @discount = Discount.find_by(name: @order.coupon)
    end

    def calculate
      {
        final_amount: @order.total_amount - discount_in_eur,
        discount_in_eur: discount_in_eur
      }
    end

    private

    def discount_in_eur
      @discount_in_eur ||=
        if @discount.present? && @discount.amount.positive?
          @discount.amount
        elsif @discount.present? && @discount.percentage.positive?
          (@order.total_amount * @discount.percentage) / 100
        else
          0
        end
    end
  end
end
