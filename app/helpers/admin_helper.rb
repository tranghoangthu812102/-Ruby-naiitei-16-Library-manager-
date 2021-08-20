module AdminHelper
  def admin_page?
    url = request.original_url.split("/")
    url[3, 2].include?("admin")
  end
end
