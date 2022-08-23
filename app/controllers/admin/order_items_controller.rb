class Admin::OrderItemsController < ApplicationController
  def update
    @order_item = OrderItem.find(params[:id])
    @order = @order_item.order
    @order_items = @order.order_items
    
    # @is_make = true
    
    @order_item.update(production_status: params[:order_item][:production_status])
      if @order_item.making_status == "now"
        @order.update(status: "now")
      end
      
      count = 0
      @order_items.each do |order_item|
        if order_detail.production_status == "finish"
          count += 1
        end
      end
      
       if count == @order_items.count
         @order.update(status: "wait")
       end
      redirect_to admin_order_path(@order.id)
  
  end
  
  private
  
  def order_item_params
    params.require(:order_detail).permit(:item_id, :order_id, :quantity, :subprice, :production_status)
  end
  
  def order_params
    params.require(:order).permit(:status)
  end
  
end
