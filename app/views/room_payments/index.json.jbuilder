# frozen_string_literal: true

json.array! @room_payments, partial: "room_payments/room_payment", as: :room_payment
