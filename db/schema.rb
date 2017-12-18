# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171218171501) do

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_products", id: false, force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "category_id", null: false
    t.index ["category_id", "product_id"], name: "index_categories_products_on_category_id_and_product_id"
    t.index ["product_id", "category_id"], name: "index_categories_products_on_product_id_and_category_id"
  end

  create_table "counties", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "password"
    t.boolean "email_confirmed"
    t.date "join_date"
    t.string "address"
    t.string "address2"
    t.integer "county_id"
    t.boolean "enabled"
    t.string "admin_notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true
  end

  create_table "customers_products", id: false, force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "product_id", null: false
    t.index ["customer_id", "product_id"], name: "index_customers_products_on_customer_id_and_product_id"
    t.index ["product_id", "customer_id"], name: "index_customers_products_on_product_id_and_customer_id"
  end

  create_table "hamper_items", force: :cascade do |t|
    t.integer "hamper_id"
    t.integer "product_id"
    t.integer "quantity"
    t.float "price_when_ordered"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hampers", force: :cascade do |t|
    t.integer "customer_id"
    t.string "name"
    t.float "price"
    t.string "greeting"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "order_id"
    t.integer "hamper_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.float "price"
    t.integer "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "delivery_first_name"
    t.string "delivery_last_name"
    t.string "delivery_address"
    t.string "delivery_address2"
    t.string "delivery_county_id"
    t.string "delivery_stripeEmail"
    t.boolean "order_fulfilled"
    t.string "delivery_stripeToken"
    t.string "delivery_stripeTokenType"
    t.string "delivery_contact_phone"
  end

  create_table "producer_images", force: :cascade do |t|
    t.integer "producer_id"
    t.string "src"
    t.boolean "primary_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "producers", force: :cascade do |t|
    t.string "name"
    t.boolean "email_confirmed"
    t.string "password"
    t.string "address"
    t.string "address2"
    t.integer "county_id"
    t.string "contact_phone"
    t.string "contact_email"
    t.date "join_date"
    t.boolean "enabled"
    t.string "admin_notes"
    t.string "about"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.index ["email"], name: "index_producers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_producers_on_reset_password_token", unique: true
  end

  create_table "product_categories", force: :cascade do |t|
    t.integer "product_id"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_images", force: :cascade do |t|
    t.integer "product_id"
    t.string "src"
    t.boolean "primary_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_likes", force: :cascade do |t|
    t.integer "product_id"
    t.integer "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.integer "producer_id"
    t.string "name"
    t.string "description"
    t.float "price"
    t.boolean "deleted"
    t.boolean "enabled"
    t.string "admin_notes"
    t.float "discount"
    t.integer "min_quantity"
    t.date "start_date"
    t.date "end_date"
    t.boolean "contains_cerials"
    t.boolean "contains_crustaceans"
    t.boolean "contains_eggs"
    t.boolean "contains_fish"
    t.boolean "contains_peanuts"
    t.boolean "contains_soybeans"
    t.boolean "contains_milk"
    t.boolean "contains_nuts"
    t.boolean "contains_celery"
    t.boolean "contains_mustard"
    t.boolean "contains_semsame"
    t.boolean "contains_sulphur"
    t.boolean "contains_lupin"
    t.boolean "contains_mullucus"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
