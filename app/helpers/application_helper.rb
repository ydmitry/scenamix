module ApplicationHelper
  def post_format(post)
    simple_format(h post)
  end

  def datetime_format(datetime)
    datetime.strftime('%d.%m.%Y, %k:%M')
  end

  def title(page_title)
    content_for :title, page_title.to_s
  end
end
