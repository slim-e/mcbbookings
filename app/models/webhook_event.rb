# frozen_string_literal: true

# == Schema Information
#
# Table name: webhook_events
#
#  id                :bigint           not null, primary key
#  source            :string
#  external_id       :string
#  data              :json
#  state             :integer          default("pending")
#  processing_errors :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class WebhookEvent < ApplicationRecord
  enum state: {pending: 0, processing: 1, processed: 2, failed: 3}
end
