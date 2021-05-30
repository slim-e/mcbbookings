class ReferenceOrderDiscount < ActiveRecord::Migration[6.1]
  def change
    remove_column :discounts, :order_id
  end
end
