class Task < ApplicationRecord
  belongs_to :user
  belongs_to :room

  enum importance: { 赤: 0, 黄: 1, 緑: 2 }
  enum status: { 未着手: 0, 実行中: 1, 終了済: 2 }
end
