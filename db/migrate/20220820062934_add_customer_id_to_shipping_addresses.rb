class AddCustomerIdToShippingAddresses < ActiveRecord::Migration[6.1]
  def change
    add_column :shipping_addresses, :customer_id, :integer
  end
end
