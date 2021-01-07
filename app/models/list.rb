class List < ApplicationRecord
  belongs_to :user
  belongs_to :room

  enum importance: { 赤: 0, 黄: 1, 青: 2 }
end
