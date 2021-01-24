class Users::ListsController < ApplicationController
  before_action :authenticate_user!

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    # ログイン中の利用者のpresent_room値をTODOリストのroom_idに代入
    @task.room_id = current_user.present_room
    @task.status = 0
    @task.save
    after_set_lists
  end

  def destroy
    set_lists
    @task.destroy
    after_set_lists
  end

  def start
    set_lists
    @task.user_id = current_user.id
    @task.status = 1
    @task.update(task_status_params)
    after_set_lists
  end

  def update
    set_lists
    @task.status = 2
    @task.update(task_status_params)
    after_set_lists
  end

  private

  def set_lists
    @task = Task.find(params[:id])
  end

  def after_set_lists
    @all_tasks      = Task.where(room_id: current_user.present_room)
    @off_tasks      = Task.where(room_id: current_user.present_room,
                                 status: 0)
    @on_tasks       = Task.where(room_id: current_user.present_room,
                                 status: 1)
    @finished_tasks = Task.where(room_id: current_user.present_room,
                                 status: 2).order(updated_at: :desc)
    @all_tasks_graph = {
      "未着手" => @off_tasks.count,
      "実行中" => @on_tasks.count,
      "終了済" => @finished_tasks.count,
    }
  end

  def task_params
    params.require(:task).permit(:body, :importance)
  end

  def task_status_params
    params.permit(:status)
  end

end
