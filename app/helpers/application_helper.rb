module ApplicationHelper
  def full_title(page_title)
    base_title = "Spyglass"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end 
  end
  def print_time(timestamp)
    if timestamp
      timestamp.strftime("%d %b %Y @ %I:%m %P %Z")
    else
      "No Value"
    end 
  end
end
