class CreateApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :applications do |t|
      t.string :name
      t.string :token, null: false, unique: true
      t.integer :chat_count, default: 0, null: false
      t.integer :next_chat_number, default: 1, null: false

      t.timestamps
    end
  end
end
