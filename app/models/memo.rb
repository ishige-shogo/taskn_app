class Memo < ApplicationRecord
  belongs_to :user
  belongs_to :room

  # メモ内容は1文字以上
  validates :body, presence: true, length: { minimum: 1 }
end
