class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!


  def new
    @order = Order.new
    @customer = Customer.find(current_customer.id)
    @shipping_addresses = current_customer.shipping_addresses.all
  end

  def confirm
    @order = Order.new(order_params)
    @cart_items = current_costomer.cart_items.all
    @order.postage = 800
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }

    # ご自身の住所の場合
    if params[:order][:address_number] == "0"
          @order = Order.new
          @order.postal_code = current_customer.postal_code
          @order.address = current_customer.address
          @order.name = current_customer.first_name + current_customer.last_name
          @order.payment_method = params[:order][:payment_method]

    # 登録済み配送先の場合
    elsif params[:order][:address_number] == "1"
      if  params[:order][:customer_id] == ""
            flash[:notice] = "お届け先の登録済住所を選択してください"
            redirect_to new_order_path
      else
        @order = Order.new
        @shipping_address = ShippingAddress.find(params[:order][:customer_id])
        @order.post_code = @shipping_address.post_code
        @order.address = @shipping_address.address
        @order.name = @shipping_address.name
        @order.payment_method = params[:order][:payment_method]
      end

    #新しいお届け先の場合
    else
      @order = Order.new
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
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
   current_costomer.cart_items.each do |cart_item|
     order_item = OrderItem.new
     order_item.item_id = cart_item.item.id
     order_item.quantity = cart_item.quantity
     order_item.price = cart_item.item.add_tax_price
     order_item.save
   end
   redirect_to orders_complete_path
   current_costomer.cart_items.all_destroy
  end

  def index
     @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @ordered_items = @order.ordered_items
    @sum = 0
    @subtotals = @order_items.map { |order_item| order_item.add_tax_price * order_item.quantity }
    @sum = @subtotals.sum
  end

  private
  def order_params
    params.require(:order).permit(:shipping_name, :shipping_address, :payment_method, :postal_code, :bill, :postage)
  end

  def address_params
    params.require(:order).permit(:name, :address, :post_code, :customer_id)
  end

end
