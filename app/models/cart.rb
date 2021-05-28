# frozen_string_literal: true

# == Schema Information
#
# Table name: carts
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  has_many :products, through: :line_items

  def sub_total
    sum = 0
    line_items.each do |item|
      sum += item.total_price
    end
    sum
  end

  def number_of_days
    number_of_days = 0
    line_items.each do |item|
      number_of_days += item.duration_of_stay
    end
    number_of_days
  end
end
