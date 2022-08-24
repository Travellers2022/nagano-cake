class Admin::OrdersController < ApplicationController
  
  def index
     @orders = Order.all.page(params[:page])
  end
  
  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items.all
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      if order_params[:status] == "confirm"
        @order.order_items.update_all(production_status:1)
      end
      redirect_to admin_order_path
    else
      render :show
    end
  end
  
  private
  
  def order_params
    params.require(:order).permit(:order_status)
  end
end
