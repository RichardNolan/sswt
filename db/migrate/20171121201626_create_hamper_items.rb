class CreateHamperItems < ActiveRecord::Migration[5.1]
  def change
    create_table :hamper_items do |t|
      t.integer :hamper_id
      t.integer :product_id
      t.integer :quantity
      t.float :price_when_ordered

      t.timestamps
    end
  end
end
