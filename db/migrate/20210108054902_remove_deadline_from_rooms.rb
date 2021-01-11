class RemoveDeadlineFromRooms < ActiveRecord::Migration[5.2]
  def change
    remove_column :rooms, :deadline, :date
  end
end
