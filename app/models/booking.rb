class Booking < ApplicationRecord
  belongs_to :user, :inverse_of => :bookings
  accepts_nested_attributes_for :user

  belongs_to :room, :inverse_of => :bookings
  accepts_nested_attributes_for :room

  belongs_to :client, :inverse_of => :bookings
  accepts_nested_attributes_for :client

  has_many :room_payments, dependent: :destroy, :inverse_of => :booking
  accepts_nested_attributes_for :room_payments
end
