class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.integer :room_id
      t.string :body
      t.integer :importance
      t.boolean :is_finished, null: false, default: false

      t.timestamps
    end
  end
end
