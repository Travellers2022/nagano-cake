class Public::OrdersController < ApplicationController
   before_action :authenticate_customer!
  
  
  def new
    @order = Order.new
    @shipping_addresses = ShippingAddress.where(customer: current_customer)
  end

  def confirm
  end

  def complete
  end

  def create
    # @cart_items = current_customer.cart_items.all
    @order = current_customer.order.new(order_params)
    
      
  end

  def index
  end

  def show
  end
end
