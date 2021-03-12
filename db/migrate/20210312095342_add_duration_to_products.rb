class AddDurationToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :duration_in_days, :integer
  end
end
