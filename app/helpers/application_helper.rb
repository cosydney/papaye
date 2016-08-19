module ApplicationHelper
  # defining a method to call to add class to active link
  def current_link(path)
    "active" if current_page?(path)
  end
end
