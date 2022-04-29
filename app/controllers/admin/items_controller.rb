class Admin::ItemsController < ApplicationController

  def new
    @new_item = Item.new
  end

  def create
    @new_item = Item.new(item_params)
    @new_item.save
    redirect_to admin_item_path(@new_item.id)
  end

  def index
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
  end


  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :genre_id, :is_active, :image)
  end

end
