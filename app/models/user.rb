# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  has_many :admins, dependent: :destroy, inverse_of: :user
  accepts_nested_attributes_for :admins

  has_many :clients, dependent: :destroy, inverse_of: :user
  accepts_nested_attributes_for :clients

  # has_many :bookings, dependent: :destroy, :inverse_of => :user
  # accepts_nested_attributes_for :bookings
  # has_many :bookings, :through => :clients

  # has_many :room_payments, dependent: :destroy, :inverse_of => :user
  # accepts_nested_attributes_for :room_payments
end
