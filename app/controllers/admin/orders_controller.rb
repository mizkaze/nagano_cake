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

  #----注文ステータスと制作ステータスの連携----
    if order.status == "verified"
      order.order_details.each do |order_detail|
        order_detail.update(making_status: 1)
        # メソッド(カラム名: enumの数字)
        # (特定の言葉でも可、その場合はクオーテーションを使う)
      end
    end

    if order.order_details.making_status == "complete"
      order.update(status: 3)
    end
  # --------

    redirect_to admin_order_path(order.id)
  end


  private

  def order_params
    params.require(:order).permit(:status)
  end



end
