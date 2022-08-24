class Admin::OrdersController < ApplicationController
  
  def index
     @orders = Order.all.page(params[:page])
  end
  
  def show
    @order = Order.find(params[:id])
   
  end

  def update
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    @order.update(order_params)
    
   if @order.order_status == "confirm"
     @order_items.update_all(production_status: "wait")
   end
    redirect_to admin_order_path(@order)     
  end
  
  private
  
  def order_params
    params.require(:order).permit(:order_status)
  end
end
