class ChangeColumnsAddStatusToOrders < ActiveRecord::Migration[6.1]
# https://qiita.com/karlley/items/4fd95f5c3898488b3f27
# 参考に↑
  def change
    change_column_default :orders, :method_of_payment, from: nil, to: "0"
    change_column_default :orders, :status, from: nil, to: "0"
  end
end
