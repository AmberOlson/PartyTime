module UsersHelper

  def email_or_name(user)
    if user.name.nil?
      user.email
    else
      user.name
    end
  end

end
