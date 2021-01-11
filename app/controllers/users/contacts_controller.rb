class Users::ContactsController < ApplicationController
  before_action :authenticate_user!
  def index
    @contacts = Contact.where(user_id: current_user.id)
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.user_id = current_user.id
    if @contact.save
      redirect_to contacts_path
    else
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:title, :body)
  end
end
