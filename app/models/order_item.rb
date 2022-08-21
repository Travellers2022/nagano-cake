class OrderItem < ApplicationRecord

  enum production_status: { cant: 0, wait: 1, now: 2, finish: 3 }
  
  
  belongs_to :order
  belongs_to :item
end
