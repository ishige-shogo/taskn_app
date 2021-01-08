class Users::MemosController < ApplicationController
  def create
    @memo = Memo.new(memo_params)
    @memo.user_id = current_user.id
    @memo.room_id = current_user.present_room
    @memo.save
    redirect_to main_path(current_user.present_room)
  end

  def destroy
    # ルームのメモを個別に削除する
    memo = Memo.find(params[:id])
    memo.destroy
    redirect_to main_path(current_user.present_room)
  end

  def destroy_all
    # ルームのメモを全て削除する
    memos = Memo.where(room_id: params[:id])
    memos.destroy_all
    redirect_to main_path(current_user.present_room)
  end

  private

  def memo_params
    params.require(:memo).permit(:body)
  end
end
