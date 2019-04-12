module ApplicationHelper
  def tags(tag)
    (params[:tag] || []) + [tag] if tag
  end
end
