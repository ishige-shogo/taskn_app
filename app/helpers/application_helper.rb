module ApplicationHelper

  def simple_date(date)
    date.strftime("%Y/%m/%d__%H:%M:%S")
  end
end
