class RemoveAdressFromShippingAddresses < ActiveRecord::Migration[6.1]
  def change
    remove_column :shipping_addresses, :adress, :string
  end
end
