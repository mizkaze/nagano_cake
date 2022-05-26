class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details

    @total = @order_details.inject(0) { |sum, item| sum + item.sum_of_price }
    @postage = 800
    @billing_amount = @total + @postage
  end

  def edit
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end
  # ↑「更新機能」に必ずしも必要なわけではなく、
  # それに対応する編集ページ(edit.html.erbなど)が存在するときにだけ必要になる

  def update
    order = Order.find(params[:id])
    order.update(order_params)
    redirect_to admin_order_path(order.id)
  end


  private

  def order_params
    params.require(:order).permit(:status)
  end



end
