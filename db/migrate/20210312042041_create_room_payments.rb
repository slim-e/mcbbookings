class CreateRoomPayments < ActiveRecord::Migration[6.1]
  def change
    create_table :room_payments do |t|
      t.string :payment_number
      t.string :status
      t.date :paid_at
      t.integer :cost
      t.string :service
      t.integer :booking_id
      t.integer :user_id

      t.timestamps
    end
    add_index :room_payments, :booking_id
    add_index :room_payments, :user_id
  end
end
