class Batch::DataUpdate
  def self.data_update
    users = User.where(is_deleted: "有効")
    users.each do |user|
      user.is_deleted = true
      user.save
    end
    p "すべてのユーザーを退会済にしました。"
    rooms = Room.where(is_deleted: "有効")
    rooms.each do |room|
      room.is_deleted = true
      room.save
    end
    p "すべてのルームを無効にしました。"
  end
end
