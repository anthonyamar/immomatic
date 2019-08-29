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

ActiveRecord::Schema.define(version: 2019_08_29_145139) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "investor_profiles", force: :cascade do |t|
    t.float "credit_years", default: 25.0
    t.float "credit_rate", default: 1.6
    t.float "credit_insurance", default: 60.0
    t.integer "number_of_investors", default: 1
    t.string "legal_form", default: "sci_is"
    t.float "net_yield_limit", default: 1.0
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "administrative_management_rate", default: 0.0, null: false
    t.index ["user_id"], name: "index_investor_profiles_on_user_id"
  end

  create_table "real_estates", force: :cascade do |t|
    t.string "ad_link"
    t.float "buying_price", null: false
    t.float "monthly_rent_estimation", null: false
    t.float "annual_charges", null: false
    t.float "works_budget", default: 0.0
    t.float "furniture_budget", default: 0.0
    t.float "others_budget", default: 0.0
    t.float "net_yield"
    t.float "annual_cashflow"
    t.string "state", null: false
    t.string "address_street"
    t.string "postal_code"
    t.string "city"
    t.string "country"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "square_meters", default: 0.0
    t.float "others_annual_fees", default: 0.0, null: false
    t.float "house_insurance", default: 120.0, null: false
    t.float "property_tax"
    t.index ["user_id"], name: "index_real_estates_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "investor_profiles", "users"
  add_foreign_key "real_estates", "users"
end
