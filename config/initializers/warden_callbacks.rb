Warden::Manager.after_set_user do |user, auth, opts|

  if auth.cookies[:membership_id].present?
    membership_id =  auth.cookies[:membership_id].to_s
    @membership = Membership.find_by(:invitiation_token => membership_id)
    @membership.update_attribute(:user_id, user.id)
    auth.cookies.delete :membership_id
  end
end
