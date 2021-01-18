class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :contacts
  has_many :memos
  has_many :rooms
  has_many :tasks
  has_many :room_users

  # refileの画像処理で必要
  attachment :image

  # デフォルト値はfalse、退会処理をするとtrueに変更
  enum is_deleted: { 有効: false, 退会済: true }

  # is_deletedカラムが有効であればtrueを返す(退会処理用)
  def active_for_authentication?
    super && (is_deleted == "有効")
  end

  # 利用者名は1文字以上
  validates :name, presence: true, length: { minimum: 1 }
end
