class CreateShippingAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :shipping_addresses do |t|
      t.string :address_line, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :zip_code, null: false
      t.string :country_code, null: false
      t.string :addressable_type, null: false
      t.integer :addressable_id, null: false

      t.timestamps
    end
  end
end
