class Admin::CustomersController < ApplicationController
  def index
    @customer = Customer.find(params[:id])
  end

  def show
  end

  def edit
  end
end
