class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  has_many :products, through: :line_items

  def total_amount
    total = 0

    line_items.each do |item|
      total += item.total_price
    end

    total
  end
end
