class Admin::OrderDetailsController < ApplicationController

  def update
    order_detail = OrderDetail.find(params[:id])
    # データは一つなので単数
    order_detail.update(order_detail_params)

    order = order_detail.order
    order_details = order.order_details

    # 「すべて＊＊だったら〇」＝「一つでも＊＊じゃなかったら×」
    is_all_completed = true
    order_details.each do |order_detail|
      if order_detail.making_status != "complete"
        is_all_completed = false
      end
    end
    if is_all_completed
      order.update(status: 3)
    end

    redirect_to admin_order_path(order_detail.order.id)

  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end


end