class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.string :text, limit: 500, null: false
      t.integer :sender, null: false
      t.integer :receiver, null: false
      t.datetime :timestamp, null: false
      t.string :sentiment, limit: 10
      t.integer :conversation, null: false

      t.timestamps
    end

    add_index :messages, :sender
    add_foreign_key :messages, :users, column: :sender
    add_index :messages, :receiver
    add_foreign_key :messages, :users, column: :receiver
    add_index :messages, :conversation
    add_foreign_key :messages, :conversations, column: :conversation
  end
end
