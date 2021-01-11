class Admins::LogsController < ApplicationController
  before_action :authenticate_admin!
  def index
  end
end
