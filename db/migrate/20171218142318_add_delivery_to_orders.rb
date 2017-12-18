class AddDeliveryToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :delivery_first_name, :string
    add_column :orders, :delivery_last_name, :string
    add_column :orders, :delivery_address, :string
    add_column :orders, :delivery_address2, :string
    add_column :orders, :delivery_county_id, :string
    add_column :orders, :delivery_stripeEmail, :string
    add_column :orders, :order_fulfilled, :boolean
  end
end
