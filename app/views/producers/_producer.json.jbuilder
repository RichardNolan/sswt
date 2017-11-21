json.extract! producer, :id, :name, :email, :email_confirmed, :password, :address, :address2, :county_id, :contact_phone, :contact_email, :join_date, :enabled, :admin_notes, :about, :created_at, :updated_at
json.url producer_url(producer, format: :json)
