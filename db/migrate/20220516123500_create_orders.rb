class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|

      # 追加
      t.integer :customer_id, null: false
      t.string :name, null: false
      t.string :postal_code, null: false
      t.string :address, null: false
      t.integer :postage, null: false
      t.integer :total_payment, null: false
      t.integer :method_of_payment, null: false
      t.integer :status, null: false

      t.timestamps
    end
  end
end