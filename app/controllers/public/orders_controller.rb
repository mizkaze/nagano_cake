class Public::OrdersController < ApplicationController
  def new
    @new_order = Order.new
  end

  def create
    # Orderモデルに必要な情報を用意する
    cart_items = current_customer.cart_items.all
    @new_order = current_customer.orders.new(order_params)

    if @new_order.save
      cart_items.eash do |cart_item|
        order_detail = OrderDetail.new
        order_detail.item_id = cart_item.item_id
        order_detail.order_id = @new_order.id
        order_detail.amount = cart_item.amount
        order_detail.price_with_tax = cart_item.item.price.add_tax_price
        order_detail.save
      end
      redirect_to thanks_public_orders_path
      cart_items.destroy_all

    else
      @new_order = Order.new(order_params)
      render :new
    end

  end

  def confirm
    @new_order = Order.new(order_params)

    if params[:order][:address_number] == "1"
      @new_order.name = current_customer.last_name+current_customer.first_name
      @new_order.address = current_customer.address

    elsif params[:order][:address_number] == "2"
      if Address.exists?(id: params[:order][:registered])
        # 「f.collection_select :registered」で指定している「配列データ個々の識別(id)」を使うため、
        # (〇〇:)の部分は、探したい情報と同じカラム名を指定する必要がある
        # viewでnameを指定していれば、こちらもnameにする
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
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
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
