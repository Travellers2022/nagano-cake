class Order < ApplicationRecord

  enum order_status: { wait: 0, confirm: 1, making:2, prepare:3, finish:4 }
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum address:[:"ご自身の住所", :"登録済みの住所から", :"新しいお届け先"]
  
  belongs_to :customer
  has_many :order_items

end
