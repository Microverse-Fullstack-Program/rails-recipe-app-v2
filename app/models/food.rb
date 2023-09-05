class Food < ApplicationRecord
  has_many :recipe_foods, dependent: :destroy
  has_many :recipes, through: :recipe_foods
  has_many :inventory_foods, dependent: :destroy
  has_many :inventories, through: :inventory_foods

  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :measurement_unit, presence: true
  validates :name, presence: true
end
