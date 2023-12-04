ActiveRecord::Schema[7.0].define(version: 2024_02_19_124429) do
  enable_extension "plpgsql"

  create_table "conversations", force: :cascade do |t|
    t.datetime "start_time", null: false
    t.datetime "end_time"
    t.string "status", limit: 10, null: false
    t.integer "participants", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["participants"], name: "index_conversations_on_participants"
  end

  create_table "messages", force: :cascade do |t|
    t.string "text", limit: 500, null: false
    t.integer "sender", null: false
    t.integer "receiver", null: false
    t.datetime "timestamp", null: false
    t.string "sentiment", limit: 10
    t.integer "conversation", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation"], name: "index_messages_on_conversation"
    t.index ["receiver"], name: "index_messages_on_receiver"
    t.index ["sender"], name: "index_messages_on_sender"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "conversations", "users", column: "participants"
  add_foreign_key "messages", "conversations", column: "conversation"
  add_foreign_key "messages", "users", column: "receiver"
  add_foreign_key "messages", "users", column: "sender"
end
