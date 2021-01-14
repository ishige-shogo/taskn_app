class Admins::ContactsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @contact_all = Contact.all
    @contacts = Contact.page(params[:page]).per(15).reverse_order
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
