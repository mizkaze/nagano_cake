class Public::CartItemsController < ApplicationController

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
  end


  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
