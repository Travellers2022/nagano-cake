class Item < ApplicationRecord
  has_one_attached :item_image
  belongs_to :genre
  has_many :cart_items, dependent: :destroy

  def add_tax_price
    (self.price_without_tax * 1.10).round
  end

  validates :name, presence: true
  validates :price_without_tax, presence: true, numericality: { only_integer: true }
  validates :is_sale, inclusion: {in: [true, false]}
  validates :genre_id, presence: true
  validates :explanation, presence: true
  validates :item_image, presence: true

end
