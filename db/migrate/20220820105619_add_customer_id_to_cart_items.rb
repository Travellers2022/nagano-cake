class AddCustomerIdToCartItems < ActiveRecord::Migration[6.1]
  def change
    add_column :cart_items, :order_id, :integer
  end
end
