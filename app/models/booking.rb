# frozen_string_literal: true

# == Schema Information
#
# Table name: bookings
#
#  id         :bigint           not null, primary key
#  status     :string
#  cost       :integer
#  start      :datetime
#  room_id    :integer
#  client_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Booking < ApplicationRecord
  # belongs_to :user
  # accepts_nested_attributes_for :user

  # belongs_to :room
  # accepts_nested_attributes_for :room

  # belongs_to :client
  # accepts_nested_attributes_for :client

  # has_many :room_payments, dependent: :destroy, :inverse_of => :booking
  # accepts_nested_attributes_for :room_payments
end
