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

  def update
    order = Order.find(params[:id])
    order.update(order_params)
    redirect_to admin_order_path

    order_details = order.order_details
    order_details.update(order_detail_params)
    redirect_to admin_order_path
  end


  private

  def order_params
    params.require(:order).permit(:status)
  end

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end

end
