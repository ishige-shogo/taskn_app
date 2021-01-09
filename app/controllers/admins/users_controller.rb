class Admins::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_is_deleted_params)
    redirect_to admins_users_path
  end

  private

  def user_is_deleted_params
    params.permit(:is_deleted)
  end
end
