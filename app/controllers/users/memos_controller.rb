class Users::MemosController < ApplicationController
  before_action :authenticate_user!
  def create
    @memo         = Memo.new(memo_params)
    @memo.user_id = current_user.id
    @memo.room_id = current_user.present_room
    @memo.save
    set_memos
  end

  def destroy
    # ルームのメモを個別に削除する
    @memo = Memo.find(params[:id])
    @memo.destroy
    set_memos
  end

  def destroy_all
    set_memos
    @memos.destroy_all
  end

  private

  def set_memos
    @memos = Memo.where(room_id: current_user.present_room)
  end

  def memo_params
    params.require(:memo).permit(:body)
  end
end
