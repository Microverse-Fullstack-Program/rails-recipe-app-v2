class Food < ApplicationRecord
  has_many :inventory_foods
  has_many :inventories, through: :inventory_foods
  has_many :recipe_foods
  has_many :recipes, through: :recipe_foods

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 50 }
  validates :measurement_unit, presence: true, length: { minimum: 2, maximum: 10 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
