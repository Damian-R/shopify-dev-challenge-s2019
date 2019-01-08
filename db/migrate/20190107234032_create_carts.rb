class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.float :subtotal
      t.float :total
      t.float :discount
      t.string :discount_code

      t.timestamps
    end
  end
end
