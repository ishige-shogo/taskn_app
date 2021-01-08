class Users::MainsController < ApplicationController
  def show
    @lists = List.where(room_id: params[:id])
    @memos = Memo.where(room_id: params[:id])
    @room = Room.find(params[:id])
    @user = User.find(current_user.id)
    @tasks = Task.where(room_id: params[:id])
    @memo = Memo.new
    @memos = Memo.where(room_id: params[:id])
  end

  def edit
  end

  def update
  end

  def out
  end
end
