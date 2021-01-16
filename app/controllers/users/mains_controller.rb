class Users::MainsController < ApplicationController
  before_action :authenticate_user!
  def show
    @off_tasks = Task.where(room_id: params[:id], status: 0)
    @room = Room.find(params[:id])
    @user = User.find(current_user.id)
    @on_tasks = Task.where(room_id: params[:id], status: 1)
    @memo = Memo.new
    @memos = Memo.where(room_id: params[:id])
    @task = Task.new
    # アクセス制限処理
    if current_user.present_room != @room.id
      redirect_to main_path(@user.present_room)
    end
  end


  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      redirect_to main_path(@room.id)
    else
      @off_tasks = Task.where(room_id: params[:id], status: 0)
      @on_tasks = Task.where(room_id: params[:id], status: 1)
      @user = User.find(current_user.id)
      @memo = Memo.new
      @memos = Memo.where(room_id: params[:id])
      @task = Task.new
      render :show
    end
  end

  private

  def room_params
    params.require(:room).permit(:name, :goal)
  end
end
