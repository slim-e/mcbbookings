# frozen_string_literal: true

class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.string :status
      t.integer :cost
      t.datetime :start
      t.integer :room_id
      t.integer :client_id

      t.timestamps
    end
    add_index :bookings, :room_id
    add_index :bookings, :client_id
  end
end
