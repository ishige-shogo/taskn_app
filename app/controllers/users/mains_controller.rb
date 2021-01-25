class Users::MainsController < ApplicationController
  before_action :authenticate_user!
  def show
    set_mains
    @task      = Task.new
    @off_tasks = Task.where(room_id: params[:id],
                            status: 0)
    @memo      = Memo.new
    @memos     = Memo.includes([:user]).where(room_id: params[:id])
    # アクセス制限
    unless current_user.present_room == @room.id
      flash[:alert_enter_room] = "他のルームに参加するためにはパスワードが必要です。"
      redirect_to main_path(current_user.present_room)
    end
  end

  def update
    set_mains
    if @room.update(room_params)
      flash[:notice_enter_room] = "ルームの設定を変更しました。"
      redirect_to main_path(@room.id)
    else
      flash[:alert_analysis] = "設定を正しく入力してください。"
      redirect_to analysis_path(current_user.present_room)
    end
  end

  private

  def set_mains
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :goal)
  end
end
