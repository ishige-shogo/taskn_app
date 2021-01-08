class Users::AnalysisController < ApplicationController
  def show

    # 未着手(TODOリストに残っているタスク)
    lists = List.where(room_id: current_user.present_room)
    # 実行中のタスク
    @on_task = Task.where(room_id: current_user.present_room, is_finished: false)
    # 終了したタスク
    @finished_tasks = Task.where(room_id: current_user.present_room, is_finished: true)
    # グラフ作成のための配列
    @all_tasks = {"未着手" => lists.count, "実行中" => @on_task.count, "終了済" => @finished_tasks.count}
    # ルームのタスクを全て合わせたもの
    @all_task = List.where(room_id: current_user.present_room).count + Task.where(room_id: current_user.present_room).count

    @logs = Log.where(room_id: current_user.present_room)

  end

  def edit
  end
end
