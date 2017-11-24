class RemoveEmailFromProducers < ActiveRecord::Migration[5.1]
  def change
    remove_column :producers, :email, :string
  end
end
