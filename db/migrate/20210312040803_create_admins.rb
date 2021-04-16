# frozen_string_literal: true

class CreateAdmins < ActiveRecord::Migration[6.1]
  def change
    create_table :admins do |t|
      t.string :first_name
      t.string :last_name
      t.integer :user_id

      t.timestamps
    end
    add_index :admins, :user_id
  end
end
