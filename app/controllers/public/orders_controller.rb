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
    if params[:order][:address_number] == "1"
          @shipping_address = ShippingAddress.find(params[:order][:shipping_address_id])
          @order.postal_code = current_customer.postal_code
          @order.address = current_customer.address
          @order.name = current_customer.first_name + current_customer.last_name

    # 登録済み配送先の場合
    elsif params[:order][:address_number] == "2"
      if  params[:order][:customer_id] == ""
            flash[:notice] = "お届け先の登録済住所を選択してください"
            redirect_to new_order_path
      else
        ship = ShippingAddress.find(params[:order][:customer_id])
        @order.post_code = ship.post_code
        @order.address = ship.address
        @order.name = ship.name
      end

    #新しいお届け先の場合
    elsif params[:order][:address_number] == "3"
      @order.post_code = params[:order][:post_code]
      @order.shipping_address = params[:order][:shipping_address]
      @order.shipping_name = params[:order][:shipping_name]

      if params[:order][:post_code] == "" || params[:order][:address] == "" || params[:order][:name] == ""
          flash[:notice] = "新しいお届け先を全て入力してください"
          redirect_to new_order_path
      end

    else
      render 'new'
      flash[:notice] = "お届け先のボタンを押してください"
    end
    

  end

  def complete
  end

  def create
    @order = current_customer.orders.new(order_params)
    @order.customer_id = current_customer.id
    @shipping_address = current_customer.shipping_addresses.new(address_params)
    if @order.save
      if params[:order][:address_number] == "3"
        @shipping_address.save
      end
      redirect_to order_orders_complete_path
    else
      render :new
    end
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
