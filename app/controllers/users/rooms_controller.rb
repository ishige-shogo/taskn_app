class Users::RoomsController < ApplicationController
  def index
    # 有効ステータスのルームのみ表示
    @rooms = Room.where(is_deleted: "有効")
  end

  def show
    @room = Room.find(params[:id])
    @user = User.find(current_user.id)
  end

  def update
    @room = Room.find(params[:id])
    @user = User.find(current_user.id)
    if @room.roompass == params[:roomkey]
      @user.roomkey = params[:roomkey]
      @user.present_room = @room.id
      redirect_to main_path(@room.id)
    else
      render :show
    end
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    # ルームのuser_idは現在ログインしている利用者ID(作成した人のデータ)
    @room.user_id = current_user.id
    if @room.save
      # 利用者のpresent_roomカラムを作成したルームIDの値にする
      user = User.find(current_user.id)
      user.present_room = @room.id
      user.save
      # 作成したルームに遷移する
      redirect_to main_path(@room.id)
    else
      render :new
    end
  end

  private

  # ルームを新規作成する際のメソッド
  def room_params
    params.require(:room).permit(:name, :roompass, :roompass_confirmation)
  end

  def user_present_room_params
    params.permit(:present_room)
  end

end
