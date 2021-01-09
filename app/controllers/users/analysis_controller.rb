class Users::AnalysisController < ApplicationController
  before_action :authenticate_user!
  def show
    @room_users = RoomUser.where(room_id: current_user.present_room)

    # 未着手のタスク
    off_tasks = Task.where(room_id: current_user.present_room, status: 0)
    # 実行中のタスク
    @on_task = Task.where(room_id: current_user.present_room, status: 1)
    # 終了したタスク
    @finished_tasks = Task.where(room_id: current_user.present_room, status: 2)
    # グラフ作成のための配列
    @all_tasks = {
      "未着手" => off_tasks.count,
      "実行中" => @on_task.count,
      "終了済" => @finished_tasks.count,
    }

    # ルームのすべてのタスク
    @all_task = Task.where(room_id: current_user.present_room).count
  end

  def edit
    @room_user = RoomUser.find(params[:id])
    @on_task = Task.where(room_id: current_user.present_room,
                          user_id: @room_user.user_id, status: 1)

    @finished_tasks = Task.where(room_id: current_user.present_room,
                                 user_id: @room_user.user_id, status: 2)
  end
end
