class InventoriesController < ApplicationController
  load_and_authorize_resource

  def index
    @inventories = current_user.inventories.includes(:inventory_foods)
    flash.delete(:notice)
  end

  def show; end

  def new
    @inventory = Inventory.new
  end

  def create
    @inventory = Inventory.new(inventory_params)
    @inventory.user_id = current_user.id

    respond_to do |format|
      if @inventory.save
        format.html { redirect_to inventories_path, notice: 'Inventory was successfully created.' }
        format.json { render :show, status: :created, location: @inventory }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end
  def update; end

  def destroy
    @inventory = Inventory.find(params[:id])

    respond_to do |format|
      if can? :destroy, @inventory
        @inventory.destroy
        format.html { redirect_to inventories_path, notice: 'Inventory was successfully deleted.' }
        format.json { head :no_content }
      else
        format.html { redirect_to inventories_path, alert: 'Inventory was not deleted.' }
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def inventory_params
    params.require(:inventory).permit(:name, :description)
  end
end
