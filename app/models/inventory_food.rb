class InventoryFood < ApplicationRecord
  belongs_to :Inventory, class_name: 'Inventory', foreign_key: 'inventory_id'
  belongs_to :food, class_name: 'Food', foreign_key: 'food_id'

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :inventory_id, uniqueness: { scope: :food_id }
  validates :food_id, presence: true, uniqueness: { scope: :inventory_id }
end
