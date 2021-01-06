class CreateLists < ActiveRecord::Migration[5.2]
  def change
    create_table :lists do |t|
      t.integer :user_id
      t.integer :room_id
      t.string :body
      t.integer :importance

      t.timestamps
    end
  end
end
