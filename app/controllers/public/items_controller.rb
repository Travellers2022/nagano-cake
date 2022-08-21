class Public::ItemsController < ApplicationController
  def index
    @items = Item.all.page(params[:page]).per(3)
    @genres = Genre.all
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
