class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price
      t.integer :duration_in_days

      t.timestamps
    end
  end
end
