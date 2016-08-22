class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  validates_uniqueness_of :user_id, scope: :event_id

  RSVP_GOING = "Going"
  RSVP_NOT_GOING = "Not going"
  RSVP_INVITED = "Invited"
  # up date to have this constant


  scope :going, -> {where(:status => RSVP_GOING)}
  scope :invited, -> {where(:status => RSVP_INVITED)}
  scope :notgoing, -> {where(:status => RSVP_NOT_GOING)}
  scope :admin, -> {where("admin = ?", true)}
  #scope :user, ->(user) {where(user: user)}

  # when a user invites another user to their event this update the membership to have status as invited and the user_id of the user invited
    def update_membership_attributes(user)
      self.update_attributes(user_id: user.id, status: RSVP_INVITED)
      self.save
    end

  #when a user invites and person that is not a current user of the site this creates a membership without a user_id and the staus invited
  def new_usermembership
    self.update_attribute(:status, RSVP_INVITED)
    self.save
  end


  # creates a token for new memberships
    def create_invitiation_token
      membership_token = Membership.new_token
      update_attribute(:invitiation_token, membership_token)
    end

  private

  # Returns a random token.
  def Membership.new_token
    SecureRandom.urlsafe_base64
  end



end
