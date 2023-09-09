class InventoryFoodsController < ApplicationController
  def index; end

  def show; end

  def new
    @inventory = Inventory.find(params[:inventory_id])
    @foods = Food.all
    @inventory_food = InventoryFood.new
  end

  def create
    @inventory = Inventory.find(params[:inventory_id])
    @inventory_food = @inventory.inventory_foods.build(inventory_food_params)

    respond_to do |format|
      if @inventory_food.save
        format.html { redirect_to @inventory, notice: 'Food was successfully added.' }
        format.json { render :show, status: :created, location: @inventory_food }
      else
        @foods = Food.all
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @inventory_food.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    @inventory_food = InventoryFood.find(params[:id])
    id = @inventory_food.inventory_id

    respond_to do |format|
      if can? :update, @inventory_food[inventory_id: id]
        if @inventory_food.update(inventory_food_params)
          format.html { redirect_to inventory_path(id), notice: 'Food was successfully updated.' }
          format.json { render :show, status: :ok, location: @inventory_food }
        else
          format.html { render :edit }
          format.json { render json: @inventory_food.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to inventory_path(id), alert: 'You are not authorized to update this food.' }
        format.json { render json: @inventory_food.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @inventory_food = InventoryFood.find(params[:id])
    id = @inventory_food.inventory_id

    respond_to do |format|
      if can? :destroy, Inventory.includes(:inventory_foods).find(id)
        @inventory_food.destroy
        format.html { redirect_to inventory_path(id), notice: 'Food was successfully removed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to inventory_path(id), alert: 'You are not authorized to remove this food.' }
        format.json { render json: @inventory_food.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def inventory_food_params
    params.require(:inventory_food).permit(:inventory_id, :food_id, :quantity)
  end
end
