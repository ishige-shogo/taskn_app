class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :contacts
  has_many :lists
  has_many :logs
  has_many :memos
  has_many :rooms
  has_many :tasks
  has_many :room_users

  attachment :image

  validates :name, presence: true, length: { minimum: 3 }
end
