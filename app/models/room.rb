class Room < ApplicationRecord
  has_many :lists
  has_many :logs
  has_many :memos
  has_many :tasks
  has_many :room_users
  belongs_to :user
end
