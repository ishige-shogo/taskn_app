class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.integer :user_id
      t.string :name
      t.string :encrypted_roompass
      t.string :encrypted_roompass_iv
      t.date :deadline
      t.boolean :is_deleted, null: false, default: false

      t.timestamps
    end
  end
end
