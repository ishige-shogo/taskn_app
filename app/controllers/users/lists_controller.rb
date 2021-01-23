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
    @off_tasks = Task.where(room_id: current_user.present_room, status: 0)
    @task = Task.find(params[:id])
    @task.destroy
  end

  def start
    task = Task.find(params[:id])
    # Taskステータスを実行中にする
    task.user_id = current_user.id
    task.status = 1
    task.update(task_status_params)
    redirect_to main_path(current_user.present_room)
  end

  def update
    task = Task.find(params[:id])
    # Taskステータスを終了済にする
    task.status = 2
    task.update(task_status_params)
    redirect_to  analysis_path(current_user.present_room)
  end

  private

  def task_params
    params.require(:task).permit(:body, :importance)
  end

  def task_status_params
    params.permit(:status)
  end
end
