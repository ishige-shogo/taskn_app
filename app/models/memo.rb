class Memo < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :body, presence: true, length: { minimum: 1 }
end
