class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart
  belongs_to :order

  validates :quantity, presence: true, numericality: { only_integer: true }

  def total_price
    quantity * product.price
  end
end
