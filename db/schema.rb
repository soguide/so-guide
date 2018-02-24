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

ActiveRecord::Schema.define(version: 20180224204026) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
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
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "bookings", force: :cascade do |t|
    t.bigint "traveler_id"
    t.bigint "guide_id"
    t.datetime "start_date"
    t.integer "rating"
    t.datetime "end_date"
    t.boolean "booked"
    t.integer "price"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guide_id"], name: "index_bookings_on_guide_id"
    t.index ["traveler_id"], name: "index_bookings_on_traveler_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.float "latitude"
    t.float "longitude"
    t.text "best_period"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
  end

  create_table "country_offerings", force: :cascade do |t|
    t.bigint "guide_id"
    t.bigint "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_country_offerings_on_country_id"
    t.index ["guide_id"], name: "index_country_offerings_on_guide_id"
  end

  create_table "country_photos", force: :cascade do |t|
    t.bigint "country_id"
    t.string "main"
    t.string "second"
    t.string "third"
    t.string "fourth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_country_photos_on_country_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "guide_contact_infos", force: :cascade do |t|
    t.string "mobile_phone"
    t.integer "years_experience"
    t.string "main_review"
    t.string "secondary_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "guide_organizations", force: :cascade do |t|
    t.string "name"
    t.string "structure_website"
    t.string "facebook_profil_url"
    t.string "facebook_structure_url"
    t.string "license"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "guide_reviews", force: :cascade do |t|
    t.bigint "guide_id"
    t.bigint "review_id"
    t.bigint "traveler_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guide_id"], name: "index_guide_reviews_on_guide_id"
    t.index ["review_id"], name: "index_guide_reviews_on_review_id"
    t.index ["traveler_id"], name: "index_guide_reviews_on_traveler_id"
  end

  create_table "guide_specialities", force: :cascade do |t|
    t.bigint "speciality_id"
    t.bigint "guide_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guide_id"], name: "index_guide_specialities_on_guide_id"
    t.index ["speciality_id"], name: "index_guide_specialities_on_speciality_id"
  end

  create_table "guides", force: :cascade do |t|
    t.bigint "guide_organization_id"
    t.bigint "guide_contact_info_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.string "full_name"
    t.string "main_photo"
    t.text "description"
    t.string "state"
    t.index ["guide_contact_info_id"], name: "index_guides_on_guide_contact_info_id"
    t.index ["guide_organization_id"], name: "index_guides_on_guide_organization_id"
    t.index ["user_id"], name: "index_guides_on_user_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.datetime "fake_date"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "specialities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spoken_languages", force: :cascade do |t|
    t.bigint "language_id"
    t.bigint "guide_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guide_id"], name: "index_spoken_languages_on_guide_id"
    t.index ["language_id"], name: "index_spoken_languages_on_language_id"
  end

  create_table "travelers", force: :cascade do |t|
    t.bigint "user_id"
    t.string "postal"
    t.string "inscription_reason"
    t.string "provider"
    t.string "uuid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["user_id"], name: "index_travelers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "year_of_birth"
    t.string "gender"
    t.boolean "admin"
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
    t.string "provider"
    t.string "uid"
    t.string "facebook_picture_url"
    t.string "token"
    t.datetime "token_expiry"
    t.string "slug"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "visiting_interests", force: :cascade do |t|
    t.bigint "country_id"
    t.bigint "traveler_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_visiting_interests_on_country_id"
    t.index ["traveler_id"], name: "index_visiting_interests_on_traveler_id"
  end

  add_foreign_key "bookings", "guides"
  add_foreign_key "bookings", "travelers"
  add_foreign_key "country_offerings", "countries"
  add_foreign_key "country_offerings", "guides"
  add_foreign_key "country_photos", "countries"
  add_foreign_key "guide_reviews", "guides"
  add_foreign_key "guide_reviews", "reviews"
  add_foreign_key "guide_reviews", "travelers"
  add_foreign_key "guide_specialities", "guides"
  add_foreign_key "guide_specialities", "specialities"
  add_foreign_key "guides", "guide_contact_infos"
  add_foreign_key "guides", "guide_organizations"
  add_foreign_key "guides", "users"
  add_foreign_key "spoken_languages", "guides"
  add_foreign_key "spoken_languages", "languages"
  add_foreign_key "travelers", "users"
  add_foreign_key "visiting_interests", "countries"
  add_foreign_key "visiting_interests", "travelers"
end
