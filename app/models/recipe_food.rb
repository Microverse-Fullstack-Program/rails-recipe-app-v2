class RecipeFood < ApplicationRecord
  belongs_to :Recipe
  belongs_to :Food
end
