class CreateChats < ActiveRecord::Migration[7.0]
  def change
    create_table :chats do |t|
      t.integer :sender_id, null: false
      t.integer :receiver_id, null: false
      t.text :content, null: false
      t.timestamp :timestamp, default: -> { 'CURRENT_TIMESTAMP' }
      t.boolean :is_ai_generated, null: false, default: false

      t.timestamps
    end

    add_foreign_key :chats, :users, column: :sender_id
    add_foreign_key :chats, :users, column: :receiver_id
  end
end
