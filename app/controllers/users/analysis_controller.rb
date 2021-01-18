class Users::AnalysisController < ApplicationController
  before_action :authenticate_user!
  def show
    @room = Room.find(current_user.present_room)
    @room_users = RoomUser.where(room_id: current_user.present_room)
    # 未着手のタスク
    @off_tasks = Task.where(room_id: current_user.present_room, status: 0)
    # 実行中のタスク
    @on_tasks = Task.where(room_id: current_user.present_room, status: 1).order(updated_at: :asc)
    # 終了したタスク
    @finished_tasks = Task.where(room_id: current_user.present_room, status: 2).order(updated_at: :desc)
    # グラフ作成のための配列
    @all_task = {
      "未着手" => @off_tasks.count,
      "実行中" => @on_tasks.count,
      "終了済" => @finished_tasks.count,
    }
    # ルームのすべてのタスク
    @all_tasks = Task.where(room_id: current_user.present_room)
    # アクセス制限
    if current_user.present_room != Room.find(params[:id]).id
      flash[:alert_analysis] = "他のルームの分析画面は閲覧できません。"
      redirect_to analysis_path(current_user.present_room)
    end
  end

  def edit
    @room = Room.find(current_user.present_room)
    @room_users = RoomUser.where(room_id: current_user.present_room)
    @room_user = RoomUser.find(params[:id])
    @on_tasks = Task.where(room_id: current_user.present_room,
                           user_id: @room_user.user_id,
                           status: 1).order(updated_at: :asc)

    @finished_tasks = Task.where(room_id: current_user.present_room,
                                 user_id: @room_user.user_id,
                                 status: 2).order(updated_at: :asc)

    # アクセス制限(同ルーム内の他のメンバーの分析画面へは遷移できる)
    unless RoomUser.where(room_id: current_user.present_room).pluck(:id).include?(@room_user.id)
      flash[:alert_analysis] = "他のルームの分析画面は閲覧できません。"
      redirect_to analysis_path(current_user.present_room)
    end
  end
end

