class Public::CustomersController < ApplicationController

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    @customer.update(customer_params)
    redirect_to public_customer_path(@customer.id)
  end

# 退会機能はこの記事を参考にすれば良かったんだと思う
# https://qiita.com/japwork/items/faca5e5ffbd5ddfff350

  def delete_confirm
    @customer = current_customer
  end

  def delete
    @customer = current_customer
    @customer.update(is_active: false)
    reset_session
    redirect_to root_path
  end


  private

  def customer_params
    params.require(:customer).permit(
      :last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number
    )
  end

end
