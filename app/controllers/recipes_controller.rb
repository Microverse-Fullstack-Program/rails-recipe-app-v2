class RecipesController < ApplicationController
  def index
    @recipes = current_user.recipes
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    if @recipe.save
      redirect_to @recipe, notice: 'Recipe was successfully created.'
    else
      puts @recipe.errors.full_messages
      render :new
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: 'Recipe was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    if @recipe.destroy
      flash[:notice] = 'Recipe deleted!'
    else
      flash[:alert] = 'Error! Please try again later.'
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :preparation_time, :cooking_time, :public)
  end
end
