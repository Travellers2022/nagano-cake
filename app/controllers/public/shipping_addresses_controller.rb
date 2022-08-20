class Public::ShippingAddressesController < ApplicationController
  before_action :authenticate_customer!
  
  
  
  def index
    @shipping_address = ShippingAddress.new
    @shipping_addresses = current_customer.shipping_addresses.all
  end

  def edit
    @shipping_address = ShippingAddress.find(params[:id])
  end

  def create
    @shipping_address = ShippingAddress.new(shipping_address_params)
    @shipping_address.customer_id = current_customer.id
    if @shipping_address.save
      flash[:notice] = "新しい配送先を登録しました"
      redirect_to　 shipping_addresses_path 
    else
      @shipping_addresses = current_customer.shipping_addresses.all
      render :index
    end
  end

  def update
    @shipping_address.find(params[:id])
    if @shipping_address.update
     flash[:notice] = "配送先を変更しました。"
     redirect_to  shipping_addresses_path
   else
     @shipping_addresses = current_customer.shipping_addresses.all
     render "edit"
    end
  end
  

  def destroy
    @shipping_address = ShippingAddress.find(params[:id])
    if @shipping_address.destroy
      redirect_to shipping_addresses_path
    end
  end
  
  private
  
  def shipping_address_params
    params.require(:shipping_address).permit(:name,:address,:postal_code)
  end

end

