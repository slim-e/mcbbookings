class CreateWebhookEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :webhook_events do |t|
      t.string 'source'
      t.string 'external_id'
      t.json 'data'
      t.integer 'state', default: 'pending'
      t.text 'processing_errors'

      t.timestamps
    end
  end
end
