# frozen_string_literal: true

# == Schema Information
#
# Table name: rooms
#
#  id         :bigint           not null, primary key
#  number     :integer
#  booked     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Room < ApplicationRecord
  has_many :clients, through: :bookings

  has_many :bookings, inverse_of: :rooms
  accepts_nested_attributes_for :bookings
end
