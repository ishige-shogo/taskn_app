class Users::ListsController < ApplicationController
  before_action :authenticate_user!

  # 使用しない可能性大
  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    # ログイン中の利用者のpresent_room値をTODOリストのroom_idに代入
    @task.room_id = current_user.present_room
    @task.status = 0
    if @task.save
      redirect_to main_path(current_user.present_room)
    else
      render :new
    end
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    redirect_to main_path(current_user.present_room)
  end

  def start
    task = Task.find(params[:id])
    task.user_id = current_user.id
    task.status = 1
    task.update(task_status_params)
    redirect_to main_path(current_user.present_room)
  end

  def update
    task = Task.find(params[:id])
    # Task終了フラグ(終了済)にする
    task.status = 2
    task.update(task_status_params)
    redirect_to main_path(current_user.present_room)
  end

  private

  def task_params
    params.require(:task).permit(:body, :importance)
  end

  def task_status_params
    params.permit(:status)
  end
end
