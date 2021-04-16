# frozen_string_literal: true

# == Schema Information
#
# Table name: line_items
#
#  id         :bigint           not null, primary key
#  quantity   :integer          default(1)
#  product_id :integer
#  cart_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :integer
#
class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart
  belongs_to :order

  validates :quantity, presence: true, numericality: {only_integer: true}

  def total_price
    quantity * product.price
  end
end
