class Task < ApplicationRecord
  belongs_to :user
  belongs_to :room

  enum importance: { HIGH: 0, MIDDLE: 1, LOW: 2 }
  enum status: { 未着手: 0, 実行中: 1, 終了済: 2 }

  # タスク内容は1文字以上
  validates :body, presence: true, length: { minimum: 1 }
end
