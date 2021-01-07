class Users::RoomsController < ApplicationController
  def index
    @rooms = Room.where(is_deleted: "有効")
  end

  def show
    @room = Room.find(params[:id])
  end

  def update
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    # ルームのuser_idは現在ログインしている利用者のID
    @room.user_id = current_user.id
    if @room.save
      redirect_to rooms_path
    else
      render :new
    end
  end

  private

  # ルームを新規作成する際のメソッド
  def room_params
    params.require(:room).permit(:name, :roompass, :roompass_confirmation)
  end
end
