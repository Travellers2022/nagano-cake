class CreateShippingAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :shipping_addresses do |t|
      
      t.string :postal_code, null: false
      t.string :adress, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
