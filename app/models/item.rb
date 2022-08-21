class Item < ApplicationRecord
  has_one_attached :item_image
  belongs_to :genre
  has_many :cart_items, dependent: :destroy

  def add_tax_price
    (self.price_without_tax * 1.10).round
  end
end
