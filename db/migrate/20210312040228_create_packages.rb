class CreatePackages < ActiveRecord::Migration[6.1]
  def change
    create_table :packages do |t|
      t.string :name
      t.integer :duration_in_days
      t.integer :price

      t.timestamps
    end
  end
end
