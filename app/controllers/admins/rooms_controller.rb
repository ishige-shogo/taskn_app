class Admins::RoomsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @room_all = Room.all
    @rooms = Room.includes([:user]).page(params[:page]).per(10)
  end

  def update
    @room = Room.find(params[:id])
    @room.update(room_is_deleted_params)
    redirect_to request.referer
  end

  private

  def room_is_deleted_params
    params.permit(:is_deleted)
  end
end
