class Order < ApplicationRecord

  def add_tax_price
    (self.price * 1.10).round
  end

  def sum_of_price
    item.taxin_price * amount
  end

  belongs_to :customer

  has_many :order_details, dependent: :destroy
  has_many :items, through: :order_details
  # 「through」＝中間テーブルをスルーしてその先のテーブルの情報を取得できるようにする
  # 「order」:「item」＝「多」：「多」であり、どちらから見ても「has_many」が成り立つ

  enum method_of_payment: { credit_card: 0, transfer: 1 }
  enum status: { hold: 0, verified: 1, making: 2, before_shipping: 3, shipped: 4 }

end
