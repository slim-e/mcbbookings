# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id               :bigint           not null, primary key
#  name             :string
#  price            :decimal(, )      default(0.0)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  duration_in_days :integer
#
class Product < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true
  validates :duration_in_days, presence: true, numericality: {only_integer: true}
end
