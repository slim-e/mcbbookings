class CartsController < ApplicationController
  # before_action :set_order

  def show
    @cart = @current_cart
  end

  def destroy
    @cart = @current_cart
    @cart.destroy
    session[:cart_id] = nil

    redirect_to root_path
  end

  # private
  #
  # def set_order
  #   @current_order = Order.new
  # end
end
