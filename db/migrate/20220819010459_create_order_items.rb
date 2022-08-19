class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      
      t.integer :quantity, null: false
      t.integer :subprice, null: false
      t.integer :production_status, null: false, default: 0

      t.timestamps
    end
  end
end
