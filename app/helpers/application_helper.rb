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

  # 既読/有効なら緑、未読/無効/退会済なら赤が返る
  def status_color(status)
    if (status == "既読") || (status == "有効")
      "text-success"
    else
      "text-danger"
    end
  end
end
