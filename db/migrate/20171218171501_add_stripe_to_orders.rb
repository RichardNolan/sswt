class AddStripeToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :delivery_stripeToken, :string
    add_column :orders, :delivery_stripeTokenType, :string
    add_column :orders, :delivery_contact_phone, :string
  end
end
