class Room < ApplicationRecord
  has_many :clients, :through => :bookings

  has_many :bookings, :inverse_of => :rooms
  accepts_nested_attributes_for :bookings
end
