# frozen_string_literal: true

module Bookings
  class RoomHandler
    attr_reader :cart, :active_orders, :unbooked_rooms

    def initialize(cart = nil)
      @cart = cart
      @active_orders = active_orders
      @unbooked_rooms = unbooked_rooms
    end

    def call
      result = { first_available_date: Time.zone.now.end_of_day, room_id: nil}

      if @unbooked_rooms.size.positive?
        return result.merge(room_id: @unbooked_rooms.first.id)
      else
        room_is_available = false
        starting_dates = ending_dates = room_ids = []

        @active_orders.each do |order, i|
          starting_dates << order.start_at
          ending_dates << order.end_at
          room_ids << order.room_id
        end

        ending_dates.each do |ending_date|
          if ending_dates[i] + @cart.number_of_days <= starting_dates[i + 1]
            room_is_available = true

            result[:first_available_date] = ending_dates[i]
            result[:room_id] = room_ids[i]
          end

          break if room_is_available
        end

        return result
      end
    end

    private

    def active_orders
      @active_orders ||=
        Order.where(paid: true).where("end_at >= ?", Time.zone.now.end_of_day)
          .order(end_at: :asc).select(:start_at, :end_at, :room_id)
    end

    def unbooked_rooms
      @unbooked_rooms ||=
        Room.where(booked: false).order(created_at: :asc).select(:id, :booked)
    end
  end
end
