class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  validates_uniqueness_of :user_id, scope: :event_id

  RSVP_GOING = 'Going'
  RSVP_NOT_GOING = 'Not going'
  RSVP_INVITED = 'Invited'
  # up date to have this constant

  scope :going, -> { where(status: RSVP_GOING) }
  scope :invited, -> { where(status: RSVP_INVITED) }
  scope :notgoing, -> { where(status: RSVP_NOT_GOING) }
  scope :admin, -> { where('admin = ?', true) }

  # creates a token for new memberships
  def create_invitiation_token
    membership_token = Membership.new_token
    update_attribute(:invitiation_token, membership_token)
  end

  # Returns a random token.
  def Membership.new_token
    SecureRandom.urlsafe_base64
  end

end
