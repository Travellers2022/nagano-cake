class OrderItem < ApplicationRecord

  enum production_status: { cant: 0, wait: 1, now: 2, finish: 3 }
  belongs_to :order
  belongs_to :item
  
  def subtotal
    add_tax_price*quantity
  end
  
  def add_tax_price
    (self.price_without_tax * 1.10).round
  end
end

