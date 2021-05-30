# frozen_string_literal: true

class Discount < ApplicationRecord
  has_many :orders

  validates :name, presence: true
  validates :percentage, presence: true
  validates :amount, presence: true
end
