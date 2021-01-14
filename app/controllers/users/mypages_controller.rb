class Users::MypagesController < ApplicationController
  before_action :authenticate_user!
  def edit
    @user = User.find(current_user.id)
    @user_rooms = RoomUser.where(user_id: current_user.id)
    # 参加したことのあるルームで状態が有効なものだけを抽出
    @exist_user_rooms = @user_rooms.select { |n| n.room.is_deleted == "有効" }
  end

  def update
    @user = User.find(current_user.id)
    # 　更新できたらルーム一覧ページに、NOなら利用者情報編集ページに遷移
    if @user.update(user_params)
      redirect_to edit_mypages_path(current_user.id)
    else
      render :edit
    end
  end

  def unsubscribe
  end

  # 退会処理(利用者の有効フラグが退会済になる)
  def withdraw
    user = User.find(current_user.id)
    user.is_deleted = true
    user.update(user_is_deleted)
    # ログアウト状態にし、ホーム画面に戻る
    reset_session
    redirect_to root_path
  end

  private

  # 利用者のニックネーム/メール/アイコンの変更
  def user_params
    params.require(:user).permit(:name, :email, :image)
  end

  # 利用者の有効フラグを「退会済」にする
  def user_is_deleted
    params.permit(:is_deleted)
  end
end
