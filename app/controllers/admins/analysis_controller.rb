class Admins::AnalysisController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.group_by_day(:created_at).count
    @rooms = Room.group_by_day(:created_at).count
  end
end
