class AddOrderNumberAndAddressableIndexes < ActiveRecord::Migration[8.0]
  def up
    # Order#number is validated as unique; the index makes that hold under
    # concurrent requests instead of only in Ruby.
    add_index :orders, :number, unique: true

    # users.id is a bigint, and every address lookup filters on both columns.
    change_column :shipping_addresses, :addressable_id, :bigint
    add_index :shipping_addresses, %i(addressable_type addressable_id), name: 'index_shipping_addresses_on_addressable'
  end

  def down
    remove_index :shipping_addresses, name: 'index_shipping_addresses_on_addressable'
    change_column :shipping_addresses, :addressable_id, :integer
    remove_index :orders, :number
  end
end
