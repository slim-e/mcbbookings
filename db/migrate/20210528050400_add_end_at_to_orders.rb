class AddEndAtToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :end_at, :datetime
  end
end
