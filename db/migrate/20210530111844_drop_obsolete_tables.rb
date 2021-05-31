class DropObsoleteTables < ActiveRecord::Migration[6.1]
  def change
    drop_table :admins
    drop_table :users
    drop_table :bookings
    drop_table :clients
    drop_table :room_payments
  end
end
