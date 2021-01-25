class Users::MypagesController < ApplicationController
  before_action :authenticate_user!
  def edit
    set_mypages
    @exist_user_rooms = RoomUser.includes([:room]).where(user_id: current_user.id).select { |n| n.room.is_deleted == "有効" }
  end

  def update
    set_mypages
    if @user.update(user_params)
      flash[:notice_mypage] = "ユーザー情報が変更されました。"
      redirect_to edit_mypages_path(current_user.id)
    else
      @exist_user_rooms = RoomUser.includes([:room]).where(user_id: current_user.id).select { |n| n.room.is_deleted == "有効" }
      flash.now[:alert_mypage] = "ニックネーム・メールアドレスを確認してください。(すでに使用されているメールアドレスは別アカウントに登録できません)"
      render :edit
    end
  end

  def unsubscribe
  end

  # 退会処理(利用者の有効フラグが退会済になる。ログアウト状態にし、ホーム画面に戻る。)
  def withdraw
    set_mypages
    @user.is_deleted = true
    @user.update(user_is_deleted)
    reset_session
    redirect_to root_path
  end

  private

  def set_mypages
    @user = User.find(current_user.id)
  end

  # 利用者のニックネーム/メール/アイコンの変更
  def user_params
    params.require(:user).permit(:name, :email, :image)
  end

  # 利用者の有効フラグを「退会済」にする
  def user_is_deleted
    params.permit(:is_deleted)
  end
end
