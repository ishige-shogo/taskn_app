class CreateMemos < ActiveRecord::Migration[5.2]
  def change
    create_table :memos do |t|
      t.integer :user_id
      t.integer :room_id
      t.string :body

      t.timestamps
    end
  end
end
