# frozen_string_literal: true

# == Schema Information
#
# Table name: room_payments
#
#  id             :bigint           not null, primary key
#  payment_number :string
#  status         :string
#  paid_at        :date
#  cost           :integer
#  service        :string
#  booking_id     :integer
#  user_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class RoomPayment < ApplicationRecord
  belongs_to :user, inverse_of: :lesson_payments
  accepts_nested_attributes_for :user

  belongs_to :booking, inverse_of: :lesson_payments
  accepts_nested_attributes_for :booking
end
