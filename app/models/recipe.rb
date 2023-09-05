class Recipe < ApplicationRecord
  belongs_to :User
  has_many :recipe_foods, dependent: :destroy
  has_many :foods, through: :recipe_foods
end
