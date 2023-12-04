class CreateConversations < ActiveRecord::Migration[7.0]
  def change
    create_table :conversations do |t|
      t.datetime :start_time, null: false
      t.datetime :end_time
      t.string :status, limit: 10, null: false
      t.integer :participants, null: false

      t.timestamps
    end

    add_index :conversations, :participants
    add_foreign_key :conversations, :users, column: :participants
  end
end
