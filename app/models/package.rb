# frozen_string_literal: true

class Package < ApplicationRecord
  has_many :bookings, dependent: :destroy
  accepts_nested_attributes_for :bookings
end
