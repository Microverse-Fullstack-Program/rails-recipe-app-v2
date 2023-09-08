module ApplicationHelper
  def notice_message
    url = Rails.application.routes.recognize_path(request.referrer)
    flash.delete(:notice) unless ['index', 'show', 'new', 'edit', 'update', 'destroy'].include?(url[:action])
  end
end
