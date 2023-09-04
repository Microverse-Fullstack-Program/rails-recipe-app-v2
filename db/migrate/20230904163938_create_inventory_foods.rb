class CreateInventoryFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :inventory_foods do |t|
      t.integer :quantity
      t.references :Inventory, null: false, foreign_key: true
      t.references :Food, null: false, foreign_key: true

      t.timestamps
    end
  end
end
