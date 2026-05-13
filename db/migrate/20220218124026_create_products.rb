class CreateProducts < ActiveRecord::Migration[6.0]
  def up
    create_table :products do |t|
      t.bigint :upc, null: false
      t.string :title, null: false
      t.text :description, null: false
      t.decimal :price, null: false, precision: 8, scale: 2
      t.decimal :weight, precision: 6, scale: 2
      t.string :weight_unit

      t.timestamps
    end

    execute 'CREATE SEQUENCE products_upc_sequence START 1000'
    execute "ALTER TABLE products ALTER COLUMN upc SET DEFAULT NEXTVAL('products_upc_sequence')"

    add_index :products, :title
    add_index :products, :upc, unique: true
  end

  def down
    drop_table :products

    execute 'DROP SEQUENCE products_upc_sequence'
  end
end
