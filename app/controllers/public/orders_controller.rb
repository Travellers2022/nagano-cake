class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!


  def new
    @order = Order.new
    @customer = Customer.find(current_customer.id)
    @shipping_addresses = current_customer.shipping_addresses.all
  end

  def confirm
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items
    @order.postage = 800
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }

    # ご自身の住所の場合
    if params[:order][:address_number] == "0"
          @order = Order.new
          @order.postal_code = current_customer.postal_code
          @order.shipping_address = current_customer.address
          @order.shipping_name = current_customer.first_name + current_customer.last_name
          @order.payment_method = params[:order][:payment_method]

    # 登録済み配送先の場合
    elsif params[:order][:address_number] == "1"
      if  params[:order][:customer_id] == ""
            flash[:notice] = "お届け先の登録済住所を選択してください"
            redirect_to new_order_path
      else
        @order = Order.new
        @shipping_address = ShippingAddress.find(params[:order][:address_id])
        @order.postal_code = @shipping_address.postal_code
        @order.shipping_address = @shipping_address.address
        @order.shipping_name = @shipping_address.name
        @order.payment_method = params[:order][:payment_method]
      end

    #新しいお届け先の場合

    else
      @order = Order.new
      @order.postal_code = params[:order][:postal_code]
      @order.shipping_address = params[:order][:address]
      @order.shipping_name = params[:order][:name]
      @order.payment_method = params[:order][:payment_method]
    end
  end

  def complete
  end

  def create
   @order = Order.new(order_params)
   @order.customer_id = current_customer.id
   @cart_items = current_customer.cart_items.all

   @order.save

   current_customer.cart_items.each do |cart_item|
     order_item = OrderItem.new
     order_item.item_id = cart_item.item.id
     order_item.quantity = cart_item.quantity
     order_item.subprice = cart_item.item.add_tax_price
     order_item.save
   end

   redirect_to order_orders_complete_path(@order.id)
   current_customer.cart_items.destroy
  end

  def index
     @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @ordered_items = @order.ordered_items
    @cart_items = current_customer.cart_items
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
  end

  private
  def order_params
    params.require(:order).permit(:shipping_name, :shipping_address, :payment_method, :postal_code, :bill, :postage)
  end
  
  def order_item_params
    params.require(:order_item).permit(:item_id, :order_id, :quantity, :subprice, :production_status)
  end

  def address_params
    params.require(:order).permit(:name, :address, :post_code, :customer_id)
  end

end
