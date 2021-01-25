class Contact < ApplicationRecord
  belongs_to :user

  enum is_read: { 未読: false, 既読: true }

  validates :title, presence: true, length: { minimum: 1, maximum: 30 }
  validates :body, presence: true, length: { minimum: 10, maximum: 400 }
end
