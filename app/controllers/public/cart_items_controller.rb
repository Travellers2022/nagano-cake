class Public::CartItemsController < ApplicationController

  before_action :authenticate_customer!

  def create
    in_cart = current_customer.cart_items.where(item_id: params[:cart_item][:item_id])
    cart_item = current_customer.cart_items.new(cart_item_params)
    if in_cart.present?
      # すでにカートに同じ商品が入っていた時のquantityの合計
      in_cart.each do |item|
        cart_item.quantity += item.quantity
        item.destroy
      end
    end
    if cart_item.save
      redirect_to cart_items_path
    else
      @item = Item.find(params[:cart_item][:item_id])
      @cart_item = CartItem.new
      @genres = Genre.all
      render root_path
    end
  end

  def index
    @cart_items = CartItem.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
  end

  def update
    @cart_items = CartItem.all
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)

  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def all_destroy
    @cart_items = CartItem.all
    @cart_items.destroy_all
    redirect_to cart_items_path
  end


  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :quantity)
  end

end
