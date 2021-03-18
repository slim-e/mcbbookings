class Product < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true
  validates :duration_in_days, presence: true, numericality: { only_integer: true }
end
