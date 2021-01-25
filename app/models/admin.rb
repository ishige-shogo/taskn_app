class Admin < ApplicationRecord
  # :registerable,:recoverableは不要なので削除
  devise :database_authenticatable, :rememberable, :validatable
end
