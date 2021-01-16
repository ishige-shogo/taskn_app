class Contact < ApplicationRecord
  belongs_to :user

  # デフォルト値はfalse、管理者が既読に変更するとtrueに
  enum is_read: { 未読: false, 既読: true }

  # お問い合わせのタイトルは1文字以上30文字以内、本文は10文字以上400文字以内
  validates :title, presence: true, length: { minimum: 1, maximum: 30 }
  validates :body, presence: true, length: { minimum: 10, maximum: 400 }
end
