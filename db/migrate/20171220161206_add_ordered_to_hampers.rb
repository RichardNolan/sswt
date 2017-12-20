class AddOrderedToHampers < ActiveRecord::Migration[5.1]
    def change
    add_column :hampers, :ordered, :boolean
    change_column_default :hampers, :ordered, false
    add_index :hampers, :ordered
  end
end
