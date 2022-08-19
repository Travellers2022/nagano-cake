class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|

      t.string :name, null: false
      t.text :explanation, null: false
      t.integer :price_without_tax, null: false
      t.boolean :is_sale, null: false, default: 
      
      t.timestamps
    end
  end
end
