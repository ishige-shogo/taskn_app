class RemoveEncryptedRoomkeyFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :encrypted_roomkey, :string
    remove_column :users, :encrypted_roomkey_iv, :string
  end
end
