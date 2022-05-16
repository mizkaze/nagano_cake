class Public::CartItemsController < ApplicationController

  def new
    @new_cart_item = CartItem.new
  end

  def create
    @new_cart_item = current_customer.cart_items.build(cart_item_params)
    @new_cart_item.customer_id = current_customer.id
    @cart_items = current_customer.cart_items.all
    # ↑下準備

    # ↓実行
    @cart_items.each do |cart_item|
      if cart_item.item_id == @new_cart_item.item_id
      # もし同じ商品があれば、
        new_amount = cart_item.amount + @new_cart_item.amount
        # 「new_amount」を右辺の和として定義
        @new_cart_item = cart_item
        #新規投稿＝既存の投稿（と同じ）
        @new_cart_item.amount = new_amount
        # 新規投稿の数量(amount)＝「new_amount」とする
      end
    end
      @new_cart_item.save!
      # saveの後ろには「!」をつけるべし
      # 同じidのものを再度saveしたとき、更新して保存してくれる
    redirect_to public_cart_items_path
  end

  def index
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to public_cart_items_path
  end

  def destroy_all
    CartItem.destroy_all
    redirect_to public_cart_items_path
  end


  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

end
