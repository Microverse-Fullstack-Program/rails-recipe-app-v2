class InventoriesController < ApplicationController
  def index
    @inventories = Inventory.all
  end

  def show
    @inventory = Inventory.find(params[:id])
  end

  def new
    @inventory = Inventory.new
  end

  def create
    @inventory = Inventory.new(inventory_params)

    respond_to do |format|
      if @inventory.save
        format.html { redirect_to inventories_path, notice: 'Inventory was successfully created.' }
        format.json { render :show, status: :created, location: @inventory }
      else
        format.html { redirect_to new_inventory_path, notice: 'Inventory was not created.' }
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end
  def update; end

  def destroy
    @inventory = Inventory.find(params[:id])

    respond_to do |format|
      if can? :destroy, @inventory.destroy
        format.html { redirect_to inventories_path, notice: 'Inventory was successfully deleted.' }
        format.json { head :no_content }
      else
        format.html { redirect_to inventories_path, notice: 'Inventory was not deleted.' }
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def inventory_params
    params.require(:inventory).permit(:name, :description, :price, :quantity)
  end
end
