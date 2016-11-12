module ApplicationHelper

  def set_title(title)
    provide(:title, title)
  end

  # Returns the full title on a per-page basis.
  def full_title(page_title="")
    base_title = "Apartment showoff"
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def pretty_datetime(date)
    return unless date
    # If it's within 0.5 seconds of the end of the day
    if (date - date.beginning_of_day).abs < 0.5
      "#{date.strftime('%B %d, %A, %Y')} at first Minute"
    elsif (date - date.end_of_day).abs < 0.5
      "#{date.strftime('%B %d, %A, %Y')} at Midnight"
    elsif (date - (date.beginning_of_day + 12.hours)).abs < 0.5
      "#{date.strftime('%B %d, %A, %Y')} at Noon"
    else
      date.strftime('%B %d, %A, %Y at %I:%M %P')
    end
  end
end
