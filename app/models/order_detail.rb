class OrderDetail < ApplicationRecord

  belongs_to :order
  belongs_to :item

  def sum_of_price
    price_with_tax * amount
  end

end
