module UsersHelper
  def avatar user
    if user.image.attached?
      image_tag user.display_image
    else
      image_tag Settings.default_avatar
    end
  end
end
