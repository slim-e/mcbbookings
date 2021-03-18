class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)

    @current_cart.line_items.each do |item|
      item.order.destroy
      @order.line_items << item
      item.cart_id = nil
    end
    @order.save

    Cart.destroy(session[:cart_id])
    session[:cart_id] = nil

    redirect_to new_order_charge_path(order_id: @order.id)
  end

  private

  def order_params
    params.require(:order).permit(:name, :email, :address, :pay_method)
  end
end
