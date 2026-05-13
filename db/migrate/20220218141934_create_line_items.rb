class CreateLineItems < ActiveRecord::Migration[6.0]
  def change
    create_table :line_items do |t|
      t.integer :product_quantity, null: false
      t.decimal :product_price, null: false, precision: 8, scale: 2
      t.references :order, null: false, foreign_key: true, index: true
      t.references :product, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
