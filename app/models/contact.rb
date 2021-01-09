class Contact < ApplicationRecord
  belongs_to :user

  # デフォルト値はfalse、管理者が既読に変更するとtrueに
  enum is_read: { 未読: false, 既読: true }

  validates :title, presence: true, length: { minimum: 1, maximum: 30 }
  validates :body, presence: true, length: { minimum: 5, maximum: 200 }
end