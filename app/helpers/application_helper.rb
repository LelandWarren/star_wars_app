module ApplicationHelper

  # Custom helper for navigation links with an "active" class if the link is the current page
  def nav_link_to(name, path)
    active_class = current_page?(path) ? "text-yellow-500 font-bold" : "text-white hover:text-gray-400"
    link_to name, path, class: active_class
  end
  
end
