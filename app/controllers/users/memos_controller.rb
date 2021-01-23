class Users::MemosController < ApplicationController
  before_action :authenticate_user!
  def create
    @memo = Memo.new(memo_params)
    @memo.user_id = current_user.id
    @memo.room_id = current_user.present_room
    @memo.save
    @memos = Memo.where(room_id: current_user.present_room)
  end

  def destroy
    @memos = Memo.where(room_id: current_user.present_room)
    # ルームのメモを個別に削除する
    @memo = Memo.find(params[:id])
    @memo.destroy
  end

  def destroy_all
    # ルームのメモを全て削除する
    @memos = Memo.where(room_id: current_user.present_room)
    @memos.destroy_all
  end

  private

  def memo_params
    params.require(:memo).permit(:body)
  end
end
