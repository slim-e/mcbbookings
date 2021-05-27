class DropTableWh < ActiveRecord::Migration[6.1]
  def change
    drop_table :table_webhook_events
  end
end
