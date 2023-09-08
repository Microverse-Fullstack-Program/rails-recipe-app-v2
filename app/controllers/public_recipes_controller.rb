class PublicRecipesController < ApplicationController
  def index
    @public_recipes = User.joins(:recipes).joins(:recipe_foods).joins(:foods)
      .select('users.id AS user_id, users.name AS user_name, recipes.id AS recipe_id,
              recipes.name AS recipe_name, recipes.description AS recipe_description,
              SUM(foods.price) AS recipe_price, COUNT(foods.id) AS recipe_quantity')
      .group('users.id, recipes.id')
      .where(public: true).order(created_at: :desc)
  end

  def show
    @recipe = Recipe.includes(:recipe_foods).find(params[:id])
    @recipe_id = @recipe.id
    @inventories = Inventory.all

    render :show
  end
end
