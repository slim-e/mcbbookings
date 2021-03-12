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
