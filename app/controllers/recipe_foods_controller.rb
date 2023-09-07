class RecipeFoodsController < ApplicationController
  def index; end

  def new
    @recipe_food = RecipeFood.new
  end

  def create
    @recipe_food = RecipeFood.new(add_ingredients_params)
    @recipe_food.recipe_id = params[:recipe_id]
    respond_to do |format|
      if @recipe_food.save
        format.html { redirect_to recipe_path(@recipe_food.recipe_id), notice: 'Ingredient added successfully.' }
        format.json { render :show, status: :created, location: @recipe_food }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe_food.errors, status: unprocessable_entity }
      end
    end
  end

  def add_ingredients_params
    params.require(:recipe_food).permit(:food_id, :quantity)
  end
end
