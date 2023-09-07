class InventoryFood < ApplicationRecord
  belongs_to :Inventory, class_name: 'Inventory', foreign_key: 'inventory_id'
  belongs_to :Food, class_name: 'Food', foreign_key: 'food_id'
end
