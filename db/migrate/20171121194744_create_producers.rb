class CreateProducers < ActiveRecord::Migration[5.1]
  def change
    create_table :producers do |t|
      t.string :name
      t.string :email
      t.boolean :email_confirmed
      t.string :password
      t.string :address
      t.string :address2
      t.integer :county_id
      t.string :contact_phone
      t.string :contact_email
      t.date :join_date
      t.boolean :enabled
      t.string :admin_notes
      t.string :about

      t.timestamps
    end
  end
end
