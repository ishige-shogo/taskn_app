class Users::MainsController < ApplicationController
  before_action :authenticate_user!
  def show
    @off_tasks = Task.where(room_id: params[:id], status: 0)
    @room = Room.find(params[:id])
    @user = User.find(current_user.id)
    @memo = Memo.new
    @memos = Memo.where(room_id: params[:id])
    @task = Task.new
    # アクセス制限処理
    if current_user.present_room != @room.id
      flash[:alert_enter_room] = "他のルームに参加するためにはパスワードが必要です。"
      redirect_to main_path(@user.present_room)
    end
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      flash[:notice_enter_room] = "ルームの設定を変更しました。"
      redirect_to main_path(@room.id)
    else
      flash[:alert_analysis] = "設定を正しく入力してください。"
      redirect_to analysis_path(current_user.present_room)
    end
  end

  private

  def room_params
    params.require(:room).permit(:name, :goal)
  end
end
