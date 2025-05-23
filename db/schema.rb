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

ActiveRecord::Schema[7.1].define(version: 2025_05_22_041117) do
  create_table "xx_ryohi_ts", force: :cascade do |t|
    t.string "RefNO", limit: 9
    t.datetime "InsTime", null: false
    t.string "InsUserID", limit: 4
    t.string "InsPGID", limit: 7
    t.datetime "UpdTime", null: false
    t.string "UpdUserID", limit: 4
    t.string "UpdPGID", limit: 8
    t.integer "UpdCount", default: 1
    t.string "RyohiTName", limit: 100
    t.string "RyohiDeatil", limit: 500
    t.string "BumonID", limit: 3
    t.string "ShinseiID", limit: 4
    t.string "Sakuban", limit: 15, null: false
    t.string "KakuteiFlag", limit: 1, default: "0"
    t.datetime "KakuteiDate", null: false
    t.string "TehaiiDetail", limit: 500
    t.integer "Fare", default: 0
    t.integer "tax", default: 0
    t.string "TKakuteiFlag", limit: 1, default: "0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "xx_user_ids", primary_key: "UserID", id: { type: :string, limit: 4 }, force: :cascade do |t|
    t.datetime "InsTime", null: false
    t.string "InsUserID", limit: 4
    t.string "InsPGID", limit: 7
    t.datetime "UpdTime", null: false
    t.string "UpdUserID", limit: 4
    t.string "UpdPGID", limit: 8
    t.integer "UpdCount"
    t.string "UserName", limit: 40
    t.string "UserKubun", limit: 1, default: "1"
    t.string "MailAdress", limit: 50, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "deleted_at"
    t.index ["MailAdress"], name: "index_xx_user_ids_on_MailAdress", unique: true
    t.index ["deleted_at"], name: "index_xx_user_ids_on_deleted_at"
  end

  create_table "xxm_bumons", force: :cascade do |t|
    t.string "BumonCD", limit: 3
    t.datetime "InsTime", null: false
    t.string "InsUserID", limit: 4
    t.string "InsPGID", limit: 7
    t.datetime "UpdTime"
    t.string "UpdUserID", limit: 4
    t.string "UpdPGID", limit: 8
    t.integer "UpdCount", default: 1
    t.string "BumonName", limit: 40
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
