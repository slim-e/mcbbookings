# frozen_string_literal: true

# == Schema Information
#
# Table name: clients
#
#  id         :bigint           not null, primary key
#  first_name :string
#  last_name  :string
#  phone      :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Client < ApplicationRecord
  belongs_to :user, inverse_of: :clients
  accepts_nested_attributes_for :user

  has_many :bookings, dependent: :destroy, inverse_of: :client
  accepts_nested_attributes_for :bookings

  has_many :room_payments, through: :bookings

  def name
    "#{first_name} #{last_name}"
  end
end
