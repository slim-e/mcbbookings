class RoomPayment < ApplicationRecord
  belongs_to :user, inverse_of: :lesson_payments
  accepts_nested_attributes_for :user

  belongs_to :booking, inverse_of: :lesson_payments
  accepts_nested_attributes_for :booking
end
