class AddPresentRoomToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :present_room, :integer
  end
end
