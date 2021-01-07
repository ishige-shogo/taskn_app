class Users::ListsController < ApplicationController
  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    @list.user_id = current_user.id
    #ログイン中の利用者のpresent_room値をTODOリストのroom_idに代入
    user = User.find(current_user.id)
    @list.room_id = user.present_room
    if @list.save
      redirect_to main_path(id: user.present_room)
    else
      render :new
    end
  end

  def destroy
    list = List.find(params[:id])
    # リダイレクト先のidを取得するためにデータを代入しておく
    list_id = list.room_id
    list.destroy
    redirect_to main_path(id: list_id)
  end

  def update
  end

  def start
  end

  private

  def list_params
    params.require(:list).permit(:body, :importance)
  end
end
