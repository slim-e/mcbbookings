# frozen_string_literal: true

class OrdersController < ApplicationController
  def new
    flash.now[:current_cart] = @current_cart

    @order = Order.new
    @first_available_date =
      Bookings::RoomHandler.new(@current_cart).call[:first_available_date]
  end

  def create
    @order = Order.new(order_params.merge!(total_amount: 0))

    # Assign line items
    @current_cart.line_items.each do |item|
      item.order&.destroy # destroy line item draft order
      @order.line_items << item # add line item to order
      item.cart_id = nil # remove cart from line item
      @order.total_amount += item.total_price #set total_amount
    end

    # Assign available room
    room_handler = Bookings::RoomHandler.new(@current_cart).call
    if @order.start_at < room_handler[:first_available_date]
      @order.errors.add(:start_at,
                        "La date de début du stage ne peut pas être avant #{room_handler[:first_available_date].strftime('%d/%m/%Y')}")
    else
      @order.room_id = room_handler[:room_id]
      @order.end_at = @order.set_end_at
    end

    # Assign coupon to total_amount
    @order.discounted_amount =
      Orders::DiscountCalculater.new(@order).calculate[:final_amount]

    if @order.valid?
      @order.save!
      @order.room.update!(booked: true)

      Cart.destroy(session[:cart_id])
      session[:cart_id] = nil

      redirect_to order_checkout_new_path(order_id: @order.id)
    else
      flash.now[:errors] = @order.errors.messages

      @first_available_date = room_handler[:first_available_date]
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:first_name, :family_name, :email, :address, :start_at, :city, :zip_code, :country,
                                  :coupon)
  end
end
