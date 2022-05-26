class OrderDetail < ApplicationRecord

  belongs_to :order
  belongs_to :item

  def sum_of_price
    price_with_tax * amount
  end

  enum making_status: { disabled: 0, wating: 1, in_the_making: 2, complete: 3 }

end
