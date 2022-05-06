class Public::ItemsController < ApplicationController

  def new
    @new_cart_item = CartItem.new
  end

  def create
    @new_cart_item = CartItem.new(cart_item_params)
    @new_cart_item.customer_id = current_customer.id
    @new_cart_item.save
    redirect_to public_cart_items_index_path
  end

  def index
    @genres = Genre.all
    if params[:genre_id]
    # もし(リンクを押したことで)[:genre_id]が送られてきたら↓
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

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
