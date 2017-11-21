class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password
      t.boolean :email_confirmed
      t.date :join_date
      t.string :address
      t.string :address2
      t.integer :county_id
      t.boolean :enabled
      t.string :admin_notes

      t.timestamps
    end
  end
end
