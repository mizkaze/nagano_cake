class Public::ItemsController < ApplicationController

  def new
    @new_cart_item = CartItem.new
  end

  def create
    @new_cart_item = CartItem.new(cart_item_params)
    @new_cart_item.customer_id = current_customer.id
    @new_cart_item.save!
    redirect_to public_cart_items_path
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
    @new_cart_item = CartItem.new
    # form_withのmodelとして、型を指定する
    # 「new」は「新しく作る」ではなく、「新しく作るための型を用意する」
    # 「param is missing or the value is empty: cart_item」は、型を提示できていないということ
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount, :customer_id)
  end
end
