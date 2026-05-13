class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.bigint :number, null: false
      t.date :date, null: false
      t.string :payment_type, null: false
      t.decimal :total_value, precision: 10, scale: 2
      t.references :customer, null: false, foreign_key: { to_table: :users }, index: true

      t.timestamps
    end
  end
end
