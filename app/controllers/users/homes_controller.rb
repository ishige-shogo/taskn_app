class Users::HomesController < ApplicationController
  def top
  end

  def how_to
  end

  # ゲストログイン用
  def new_guest
    user = User.new(user_params)
    user.name = "ゲストユーザー"
    user.email = SecureRandom.alphanumeric(15) + "@email.com"
    user.password = SecureRandom.alphanumeric(10)
    user.save
    sign_in user
    redirect_to how_to_path
  end

  private

  def user_params
    params.permit(:name, :email, :password)
  end
end
