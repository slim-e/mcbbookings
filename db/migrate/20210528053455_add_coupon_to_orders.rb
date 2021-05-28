class AddCouponToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :coupon, :string
  end
end
