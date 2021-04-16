# frozen_string_literal: true

class OrdersController < ApplicationController
  def new
    flash.now[:current_cart] = @current_cart

    @order = Order.new
  end

  def create
    @order = Order.new(order_params)

    @current_cart.line_items.each do |item|
      item.order&.destroy
      @order.line_items << item
      item.cart_id = nil
    end

    if @order.valid?
      @order.save!

      Cart.destroy(session[:cart_id])
      session[:cart_id] = nil

      redirect_to new_order_charge_path(order_id: @order.id)
    else
      flash.now[:errors] = @order.errors.full_messages

      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:first_name, :family_name, :email, :address, :start_at, :city, :zip_code, :country)
  end
end
