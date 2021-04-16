# frozen_string_literal: true

class ModifyBookingTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :packages

    # create_table 'products', force: :cascade do |t|
    #   t.string   'name'
    #   t.decimal  'price', default: 0.0
    #   t.integer  'duration_in_days', default: 7
    #   t.datetime 'created_at', null: false
    #   t.datetime 'updated_at', null: false
    # end
    #
    # create_table 'carts', force: :cascade do |t|
    #   t.datetime 'created_at', null: false
    #   t.datetime 'updated_at', null: false
    # end
    #
    # create_table 'line_items', force: :cascade do |t|
    #   t.integer  'quantity',   default: 1
    #   t.integer  'product_id'
    #   t.integer  'cart_id'
    #   t.datetime 'created_at', null: false
    #   t.datetime 'updated_at', null: false
    #   t.integer  'order_id'
    # end
    #
    # create_table 'orders', force: :cascade do |t|
    #   t.string   'name'
    #   t.string   'email'
    #   t.text     'address'
    #   t.string   'pay_method'
    #   t.datetime 'created_at', null: false
    #   t.datetime 'updated_at', null: false
    # end
  end
end
