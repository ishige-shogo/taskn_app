class Admins::UsersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @user_all = User.all
    @users = User.page(params[:page]).per(10)
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_is_deleted_params)
    redirect_to request.referer
  end

  private

  def user_is_deleted_params
    params.permit(:is_deleted)
  end
end
