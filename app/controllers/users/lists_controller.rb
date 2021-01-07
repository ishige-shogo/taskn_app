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
      redirect_to main_path(current_user.present_room)
    else
      render :new
    end
  end

  def destroy
    list = List.find(params[:id])
    list.destroy
    redirect_to main_path(current_user.present_room)
  end

  def start
    list = List.find(params[:id])
    #ListのデータをTaskに移動させた後に消去
    task = Task.new
    task.user_id = current_user.id
    task.room_id = list.room_id
    task.body = list.body
    task.importance = list.importance
    task.save
    list.destroy
    redirect_to main_path(current_user.present_room)
  end


  def update
    task = Task.find(params[:id])
    #Task終了フラグ(終了済)にする
    task.is_finished = true
    task.save
    redirect_to main_path(current_user.present_room)
  end



  private

  def list_params
    params.require(:list).permit(:body, :importance)
  end

end
