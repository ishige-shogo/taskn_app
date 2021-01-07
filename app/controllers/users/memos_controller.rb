class Users::MemosController < ApplicationController
  def create
    @memo = Memo.new(memo_params)
    @memo.user_id = current_user.id
    @memo.room_id = current_user.present_room
    @memo.save
    redirect_to
  end

  def destroy
  end

  def destroy_all
  end

  private

  def memo_params
    params.require(:memo).permit(:body)
  end
end
