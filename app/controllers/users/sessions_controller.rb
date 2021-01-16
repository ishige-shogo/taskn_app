# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :authenticate_user!
  before_action :reject_user, only: [:create]
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # ログイン後マイページに遷移する処理
  def after_sign_in_path_for(resource)
    edit_mypages_path(current_user)
  end

  # 退会した利用者がログインできないようにする処理
  def reject_user
    user = User.find_by(email: params[:user][:email].downcase)
    if user
      if user.valid_password?(params[:user][:password]) && (user.active_for_authentication? != true)
        flash[:notice] = "退会済です"
        redirect_to new_user_session_path
      end
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
