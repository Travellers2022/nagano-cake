class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      
      t.integer :postage, null: false, default: 800
      t.integer :bill, null: false
      t.string :shipping_name, null: false
      t.string :shipping_address, null: false
      t.string :postal_code, null: false
      t.integer :order_status, null: false, default: 0
      t.integer :payment_method, null: false, default: 0

      t.timestamps
    end
  end
end
