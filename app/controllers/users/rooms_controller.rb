class Users::RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    # 有効ステータスのルームのみ表示
    @rooms = Room.where(is_deleted: "有効")
    @room_all = Room.all
  end

  def show
    @room = Room.find(params[:id])
    @user = User.find(current_user.id)
    # アクセス制限処理
    if @room.is_deleted == "無効"
      redirect_to rooms_path
    end
  end

  def search
    redirect_to room_path(id: (params[:search_room]).to_i)
  end

  def update
    @room = Room.find(params[:id])
    @user = User.find(current_user.id)
    # 入力されたものとルームのパスワードが合致すればルームに入れる
    if @room.roompass == params[:roomkey]
      @user.present_room = @room.id
      @user.save
      # RoomUserテーブルに保存するための処理
      room_user = RoomUser.new
      room_user.user_id = User.find(current_user.id).id
      room_user.room_id = @room.id
      # 過去に一度でもルームに入ったことがあれば、RoomUserテーブルに保存されない(重複データを阻止)
      if RoomUser.find_by(user_id: room_user.user_id, room_id: room_user.room_id)
        room_user.destroy
      else
        room_user.save
      end
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
      # RoomUserテーブルに保存するための処理
      room_user = RoomUser.new
      room_user.user_id = User.find(current_user.id).id
      room_user.room_id = @room.id
      room_user.save
      # 作成したルームに遷移する
      redirect_to main_path(@room.id)
    else
      render :new
    end
  end



  private

  # ルームを新規作成する際のメソッド
  def room_params
    params.require(:room).permit(:name, :goal, :roompass, :roompass_confirmation)
  end
end
