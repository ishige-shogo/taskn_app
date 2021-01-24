class Users::ContactsController < ApplicationController
  before_action :authenticate_user!
  def new
    @contacts = Contact.where(user_id: current_user.id).reverse_order
    @contact = Contact.new
  end

  def create
    @contacts = Contact.where(user_id: current_user.id)
    @contact = Contact.new(contact_params)
    @contact.user_id = current_user.id
    if @contact.save
      flash[:notice_contact] = "お問い合わせが送信されました。"
      redirect_to new_contact_path
    else
      flash.now[:alert_contact] = "タイトル・お問い合わせ内容を確認してください。"
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:title, :body)
  end
end
