class Admins::RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end

  def update
    @room = Room.find(params[:id])
    @room.update(room_is_deleted_params)
    redirect_to admins_rooms_path
  end

  private

  def room_is_deleted_params
    params.permit(:is_deleted)
  end
end
