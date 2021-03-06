class Users::AnalysisController < ApplicationController
  before_action :authenticate_user!

  def show
    set_analysis
    @all_tasks_graph = {
      "未着手" => @off_tasks.count,
      "実行中" => @on_tasks.count,
      "終了済" => @finished_tasks.count,
    }
    # アクセス制限
    unless current_user.present_room == Room.find(params[:id]).id
      flash[:alert_analysis] = "他のルームの分析画面は閲覧できません。"
      redirect_to analysis_path(current_user.present_room)
    end
  end

  def edit
    set_analysis
    @room_user           = RoomUser.find(params[:id])
    @on_tasks_user       = @on_tasks.where(user_id: @room_user.user_id)
    @finished_tasks_user = @finished_tasks.where(user_id: @room_user.user_id)
    # アクセス制限
    unless RoomUser.where(room_id: current_user.present_room).pluck(:id).include?(@room_user.id)
      flash[:alert_analysis] = "他のルームの分析画面は閲覧できません。"
      redirect_to analysis_path(current_user.present_room)
    end
  end

  private

  def set_analysis
    @room           = Room.find(current_user.present_room)
    @room_users     = RoomUser.includes([:user]).where(room_id: current_user.present_room)
    @all_tasks      = Task.where(room_id: current_user.present_room)
    @off_tasks      = Task.where(room_id: current_user.present_room,
                                 status: 0)
    @on_tasks       = Task.includes([:user]).where(room_id: current_user.present_room,
                                                   status: 1).order(updated_at: :asc)
    @finished_tasks = Task.includes([:user]).where(room_id: current_user.present_room,
                                                   status: 2).order(updated_at: :desc)
  end
end
