class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  
  def new
    @order = Order.new
    @customer = Customer.find(current_customer.id)
    @shipping_addresses = @customer.shipping_addresses
  end

  def confirm
    @order = Order.new(order_params)
    @shipping_address = ShippingAddress.find(params[:order][:shipping_address_id])
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.first_name + current_customer.last_name
  end

  def complete
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id 
    @order.save
    redirect_to complete_path
  end

  def index
  end

  def show
  end
  
  private
  def order_params
    params.require(:order).permit(:name, :address, :payment_method, :postal_code, :bill)
  end
end
