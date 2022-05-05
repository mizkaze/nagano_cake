class Public::ItemsController < ApplicationController
  def index
    @genres = Genre.all
    if params[:genre_id]
      @item = Item.where(genre_id: params[:genre_id], is_active: true)
      # 「genre_id:」はカラム名、「[:genre_id]」は自分で命名した”なんでもいい”名前
    else
      @item = Item.where(is_active: true)
    end
  end

  def show
    @genres = Genre.all
    @item = Item.find(params[:id])
  end
end
