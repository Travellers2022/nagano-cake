class Admin::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(3)
  end

  def new
    @item = Item.new
    @genre = Genre.all
  end

  def create
    @item = Item.new(item_params)
    @genre = Genre.all
    @item.save
    redirect_to admin_item_path(@item)

  end

  def show
  end

  def edit
  end

  def update
  end

  private

  def
    item_params
    params.require(:item).permit(:item_image, :name, :explanation, :genre_id, :price_without_tax, :is_sale)
  end
end
