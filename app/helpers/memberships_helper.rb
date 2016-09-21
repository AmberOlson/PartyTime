module MembershipsHelper
  def membership_email_or_name(membership)
    if membership.user.name.nil?
      membership.user.email
    else
      membership.user.name
    end
  end

end
