class Admins::ContactsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @contacts = Contact.all.order(id: "DESC")
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def update
    @contact = Contact.find(params[:id])
    @contact.is_read = true
    @contact.update(contact_is_read_params)
    redirect_to admins_contact_path(@contact.id)
  end

  private

  def contact_is_read_params
    params.permit(:is_read)
  end
end
