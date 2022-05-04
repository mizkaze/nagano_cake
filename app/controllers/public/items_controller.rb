class Public::ItemsController < ApplicationController
  def index
    @genres = Genre.all
  end

  def show
    @genres = Genre.all
    @item = Item.find(params[:id])
  end
end
