json.extract! customer, :id, :first_name, :last_name, :email, :password, :email_confirmed, :join_date, :address, :address2, :county_id, :enabled, :admin_notes, :created_at, :updated_at
json.url customer_url(customer, format: :json)
