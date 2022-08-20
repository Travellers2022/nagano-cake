class Item < ApplicationRecord
  has_one_attached :item_image
  belongs_to :genre

  def add_tax_price
    (self.price_without_tax * 1.10).round
  end
end
