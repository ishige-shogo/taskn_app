class AddGoalToRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :goal, :string
  end
end
