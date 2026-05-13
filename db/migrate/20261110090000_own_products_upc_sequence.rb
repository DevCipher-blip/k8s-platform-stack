# The UPC sequence was created with raw SQL, so db/schema.rb never recorded it
# and `db:schema:load` failed on a fresh database. Renaming it to the
# `<table>_<column>_seq` convention and tying it to the column lets the schema
# dumper emit `t.bigserial "upc"`, which recreates the sequence on load.
class OwnProductsUpcSequence < ActiveRecord::Migration[6.0]
  def up
    execute 'ALTER SEQUENCE products_upc_sequence RENAME TO products_upc_seq'
    execute 'ALTER SEQUENCE products_upc_seq OWNED BY products.upc'
    change_column_default :products, :upc, -> { "nextval('products_upc_seq'::regclass)" }
  end

  def down
    execute 'ALTER SEQUENCE products_upc_seq OWNED BY NONE'
    execute 'ALTER SEQUENCE products_upc_seq RENAME TO products_upc_sequence'
    change_column_default :products, :upc, -> { "nextval('products_upc_sequence'::regclass)" }
  end
end
