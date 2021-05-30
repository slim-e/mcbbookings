class AddDiscountedAmountToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :discounted_amount, :integer
  end
end
