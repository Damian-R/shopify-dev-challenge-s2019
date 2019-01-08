class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :title
      t.float :price
      t.integer :inventory_count
      t.string :category

      t.timestamps
    end
  end
end
