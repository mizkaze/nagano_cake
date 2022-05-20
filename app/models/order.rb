class Order < ApplicationRecord

  belongs_to :customer

  has_many :order_details, dependent: :destroy

  enum method_of_payment: { credit_card: 0, transfer: 1 }
  enum status: { hold: 0, verified: 1, making: 2, before_shipping: 3, shipped: 4 }

end
