class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.integer :producer_id
      t.string :name
      t.string :description
      t.float :price
      t.boolean :deleted
      t.boolean :enabled
      t.string :admin_notes
      t.float :discount
      t.integer :min_quantity
      t.date :start_date
      t.date :end_date
      t.boolean :contains_cerials
      t.boolean :contains_crustaceans
      t.boolean :contains_eggs
      t.boolean :contains_fish
      t.boolean :contains_peanuts
      t.boolean :contains_soybeans
      t.boolean :contains_milk
      t.boolean :contains_nuts
      t.boolean :contains_celery
      t.boolean :contains_mustard
      t.boolean :contains_semsame
      t.boolean :contains_sulphur
      t.boolean :contains_lupin
      t.boolean :contains_mullucus

      t.timestamps
    end
  end
end
