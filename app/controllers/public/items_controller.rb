class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(8)
    @genres = Genre.all
    @total_items = Item.count
  end
  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item = CartItem.new
  end

  private

  def
    item_params
    params.require(:item).permit(:item_image, :name, :explanation, :genre_id, :price_without_tax)
  end
end
