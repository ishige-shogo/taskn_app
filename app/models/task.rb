class Task < ApplicationRecord
  belongs_to :user
  belongs_to :room

  enum importance: { 赤: 0, 黄: 1, 青: 2 }
  enum is_finished: { 担当中: false, 終了済: true }
end
