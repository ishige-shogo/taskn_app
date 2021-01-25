class User < ApplicationRecord
  # :recoverableは不要なので削除
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  has_many :contacts
  has_many :memos
  has_many :rooms
  has_many :tasks
  has_many :room_users

  # 退会処理用(users::sessions_controllerで使用)
  def active_for_authentication?
    super && (is_deleted == "有効")
  end

  # refileの画像処理で必要
  attachment :image

  enum is_deleted: { 有効: false, 退会済: true }

  validates :name, presence: true, length: { minimum: 1 }
end
