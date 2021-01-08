class Users::MainsController < ApplicationController
  def show
    @lists = List.where(room_id: params[:id])
    @room = Room.find(params[:id])
    @user = User.find(current_user.id)
    @tasks = Task.where(room_id: params[:id])
    @memo = Memo.new
    @memos = Memo.where(room_id: params[:id])
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      redirect_to main_path(@room.id)
    else
      render :edit
    end
  end


  private

  def room_params
    params.require(:room).permit(:name, :goal, :roompass, :roompass_confirmation)
  end


end
