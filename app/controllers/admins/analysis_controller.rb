class Admins::AnalysisController < ApplicationController
  def index
    @users = User.group_by_day(:created_at).count
    @rooms = Room.group_by_day(:created_at).count
  end
end
