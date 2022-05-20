class Public::OrdersController < ApplicationController
  def new
    @new_order = Order.new
  end

  def create
    # Orderモデルに必要な情報を用意する
    @new_order = current_customer.new(order_params)
    @new_order.save
    redirect_to confirm_public_orders_path
  end

  def confirm
    @new_order = Order.new(order_params)

    if params[:order][:address_number] == "1"
      @new_order.name = current_customer.name
      @new_order.address = current_customer.address

    elsif params[:order][address_number] == "2"
      if Address.exists?(name: params[:order][:registered])
        @new_order.name = Address.find(params[:order][:registered]).name
        @new_order.address = Address.find(params[:order][:registered]).address
      else
        render :new
      end

    elsif params[:order][:address_number] == "3"
      new_address = current_customer.address.new(address_params)
      if new_address.save
      else
        render :new
      end

    else
      redirect_to root_path
    end

    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_price }
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

  def address_params
    params.require(:order).permit(:name, :poatal_code, :address)
  end
end
