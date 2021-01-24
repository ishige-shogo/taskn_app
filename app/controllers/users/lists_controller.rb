class Users::ListsController < ApplicationController
  before_action :authenticate_user!

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    # ログイン中の利用者のpresent_room値をTODOリストのroom_idに代入
    @task.room_id = current_user.present_room
    @task.status = 0
    @task.save
    @off_tasks = Task.where(room_id: current_user.present_room, status: 0)
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    @all_tasks = Task.where(room_id: current_user.present_room)
    @off_tasks = Task.where(room_id: current_user.present_room, status: 0)
    @on_tasks = Task.where(room_id: current_user.present_room, status: 1)
    @finished_tasks = Task.where(room_id: current_user.present_room, status: 2).order(updated_at: :desc)
    @all_tasks_graph = {
      "未着手" => @off_tasks.count,
      "実行中" => @on_tasks.count,
      "終了済" => @finished_tasks.count,
    }
  end

  def start
    @off_tasks = Task.where(room_id: current_user.present_room, status: 0)
    task = Task.find(params[:id])
    # Taskステータスを実行中にする
    task.user_id = current_user.id
    task.status = 1
    task.update(task_status_params)
  end

  def update
    task = Task.find(params[:id])
    # Taskステータスを終了済にする
    task.status = 2
    task.update(task_status_params)
    @all_tasks = Task.where(room_id: current_user.present_room)
    @off_tasks = Task.where(room_id: current_user.present_room, status: 0)
    @on_tasks = Task.where(room_id: current_user.present_room, status: 1)
    @finished_tasks = Task.where(room_id: current_user.present_room, status: 2).order(updated_at: :desc)
    @all_tasks_graph = {
      "未着手" => @off_tasks.count,
      "実行中" => @on_tasks.count,
      "終了済" => @finished_tasks.count,
    }
  end

  private

  def task_params
    params.require(:task).permit(:body, :importance)
  end

  def task_status_params
    params.permit(:status)
  end
end
