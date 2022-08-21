class Public::CartItemsController < ApplicationController
  def index
  end

  def update
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def all_destroy
  end

  def create
  end
end
