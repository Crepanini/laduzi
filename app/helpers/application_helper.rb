module ApplicationHelper
  def tags(tag)
    [tag].push(params[:tag])
  end
end
