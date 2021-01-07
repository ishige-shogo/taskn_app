class Users::ListsController < ApplicationController
  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    @list.user_id = current_user.id

    room = Room.find(params[:id])
    @list.room_id = room.id

    if @list.save
      redirect_to
    else
      render :new
    end
  end

  def destroy
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
