class CreateProductLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :product_likes do |t|
      t.integer :product_id
      t.integer :customer_id

      t.timestamps
    end
  end
end
