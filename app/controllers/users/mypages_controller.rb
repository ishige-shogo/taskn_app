class Users::MypagesController < ApplicationController
  def edit
    # 現在ログインしているuserの情報を取得
    @user = User.find(current_user.id)
  end

  def update
    # 現在ログインしているuserの情報を取得
    @user = User.find(current_user.id)
    @user.update(user_params)
    redirect_to rooms_path
  end

  def unsubscribe
  end

  def withdraw
  end

  private
  # 利用者のニックネーム/メール/アイコンの変更
  def user_params
    params.require(:user).permit(:name, :email, :image)
  end
end
