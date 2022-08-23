class Admin::OrdersController < ApplicationController
  
  def index
     @orders = Order.all.page(params[:page])
  end
  
  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items.all
    @sum = 0
    @subtotals = @order_items.map { |order_item| order_item.add_tax_price * order_item.quantity }
    @sum = @subtotals.sum
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
