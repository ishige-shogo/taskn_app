class Room < ApplicationRecord

  has_many :memos
  has_many :tasks
  has_many :room_users
  belongs_to :user

  # gem attr_encrypted の記述、カラムの暗号化復号化に使用
  attr_encrypted :roompass, key: ENV['ROOMPASS']

  # デフォルト値はfalse、管理者が無効処理をするとtrueに変更
  enum is_deleted: { 有効: false, 無効: true }

  validates :name, presence: true, length: { minimum: 1, maximum: 20 }
  validates :roompass, presence: true, length: { minimum: 3, maximum: 20 }, confirmation: true
end
