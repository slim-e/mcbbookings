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
  has_many :orders, dependent: :destroy

  validates :booked, inclusion: [true, false]
  validates :number, presence: true, numericality: {only_integer: true}
end
