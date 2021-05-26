class AddMissingColumnsToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :city, :string
    add_column :orders, :country, :string
    add_column :orders, :zip_code, :string
    add_column :orders, :pay_method, :string
    add_column :orders, :stripe_payment_intent_id, :string
    add_column :orders, :stripe_checkout_session_id, :string
    add_column :orders, :stripe_customer_id, :string
  end
end
