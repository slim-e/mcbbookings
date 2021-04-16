# frozen_string_literal: true

class AddAttributesToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :family_name, :string, null: false, default: ""
    change_column_default :orders, :name, ""
    rename_column :orders, :name, :first_name
    add_column :orders, :start_at, :datetime
    add_column :orders, :paid, :boolean, default: false
  end
end
