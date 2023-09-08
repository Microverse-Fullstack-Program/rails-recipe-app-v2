class RecipesController < ApplicationController
  load_and_authorize_resource
  include ApplicationHelper

  def index
    notice_message
    @recipes = current_user.recipes.includes(:recipe_foods)
  end

  def show
    Recipe.includes(:recipe_foods).find(params[:id])
    @inventories = Inventory.all

    render :show
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    @recipe.public = params[:public] == 'Public'

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipes_path, notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: unprocessable_entity }
      end
    end
  end

  def edit; end
  def update; end

  def destroy
    @recipe = Recipe.find(params[:id])

    respond_to do |format|
      if can? :destroy, @recipe
        @recipe.destroy
        format.html { redirect_to recipes_path, notice: 'Recipe was successfully deleted.' }
        format.json { head :no_content }
      else
        format.html { redirect_to recipes_path, alert: 'Recipe was not deleted.' }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def shopping_list
    @recipe = Recipe.find(params[:recipe_id])
    @inventory = Inventory.find(params[:inventory_id])
    recipe_foods = @recipe.recipe_foods.includes(:food)
    inventory_foods = @inventory.inventory_foods.includes(:food)

    recipe_foods.each do |recipe_food|
      inventory_food = inventory_foods.find_by(food_id: recipe_food.food_id)
      if inventory_food
        inventory_food.quantity += recipe_food.quantity
        inventory_food.save
      else
        @inventory.inventory_foods.create(food_id: recipe_food.food_id, quantity: recipe_food.quantity)
      end
    end

    redirect_to recipe_path(@recipe)
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
