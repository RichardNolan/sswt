class CreateHampers < ActiveRecord::Migration[5.1]
  def change
    create_table :hampers do |t|
      t.integer :customer_id
      t.string :name
      t.float :price
      t.string :greeting

      t.timestamps
    end
  end
end
