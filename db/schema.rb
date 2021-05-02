# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_17_202617) do

  create_table "tags", charset: "utf8", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "last_search"
    t.index ["user_id"], name: "index_tags_on_user_id"
  end

  create_table "tags_things", id: false, charset: "utf8", force: :cascade do |t|
    t.bigint "tag_id", null: false
    t.bigint "thing_id", null: false
    t.index ["tag_id", "thing_id"], name: "index_tags_things_on_tag_id_and_thing_id"
    t.index ["thing_id", "tag_id"], name: "index_tags_things_on_thing_id_and_tag_id"
  end

  create_table "things", charset: "utf8", force: :cascade do |t|
    t.string "title"
    t.string "content_type"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "raw_tags"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_things_on_user_id"
  end

  create_table "users", charset: "utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "things", "users"
end
