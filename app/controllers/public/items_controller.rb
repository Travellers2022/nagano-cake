class Public::ItemsController < ApplicationController
  def index
    @genres = Genre.all
    @items = Item.page(params[:page]).per(3)
  end
  def show
    @genres = Genre.all
    @item = Item.find(params[:id])
  end

  private

  def
    item_params
    params.require(:item).permit(:item_image, :name, :explanation, :genre_id, :price_without_tax)
  end
end
