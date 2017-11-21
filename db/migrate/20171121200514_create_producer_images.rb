class CreateProducerImages < ActiveRecord::Migration[5.1]
  def change
    create_table :producer_images do |t|
      t.integer :producer_id
      t.string :src
      t.boolean :primary_image

      t.timestamps
    end
  end
end
