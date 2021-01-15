module ApplicationHelper
  # 年月日表示
  def simple_date(date)
    date.strftime("%Y/%m/%d")
  end

  # 時間表示
  def simple_time(time)
    time.strftime("%H:%M:%S")
  end

  # テキストの内容表示(11文字以上なら「10文字...」と表示する)
  def simple_body(body)
    if body.length >= 11
      body[0..9] + "..."
    else
      body
    end
  end

  # テキストの色が既読/有効/低いなら緑、普通なら黄、未読/無効/退会済/高いなら赤
  def status_color(status)
    if (status == "既読") || (status == "有効") || (status == "LOW")
      "text-success"
    elsif status == "MIDDLE"
      "text-warning"
    else
      "text-danger"
    end
  end

end
