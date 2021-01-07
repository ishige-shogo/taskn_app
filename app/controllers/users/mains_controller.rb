class Users::MainsController < ApplicationController
  def show
    @room = Room.find(params[:id])
    @user = User.find(current_user.id)
  end

  def edit
  end

  def update
  end

  def out
  end
end
