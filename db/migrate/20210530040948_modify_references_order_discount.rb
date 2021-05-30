class ModifyReferencesOrderDiscount < ActiveRecord::Migration[6.1]
  def change
    remove_column :discounts, :orders_id
    add_reference :discounts, :order, index: true
  end
end
