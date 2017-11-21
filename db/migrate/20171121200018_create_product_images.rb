class CreateProductImages < ActiveRecord::Migration[5.1]
  def change
    create_table :product_images do |t|
      t.integer :product_id
      t.string :src
      t.boolean :primary_image

      t.timestamps
    end
  end
end
