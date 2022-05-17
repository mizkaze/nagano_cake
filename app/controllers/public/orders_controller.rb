class Public::OrdersController < ApplicationController
  def new
    @new_order = Order.new
  end

  def create
    new_order = Order.new(order_params)
    new_order.save
    redirect_to confirm_public_orders_path
  end

  def confirm
  end

  def thanks
  end

  def index
  end

  def show
  end


  private

  def order_params
    params.require(:order).permit(
      :name, :postal_code, :address, :postage, :total_payment, :method_of_payment, :status
    )
  end
end
