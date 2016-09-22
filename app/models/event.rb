class Event < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  validates :title, presence: true,
                    length: { minimum: 2 }
  validates :date, presence: true
  validates :time, presence: true

  # when a user creates a event this creates the users membership to that event
  # automatically sets user as the admin and status going
  def create_admin_membership(current_user)
    memberships.create(user_id: current_user.id,
                       admin: true,
                       status: Membership::RSVP_GOING)
  end

  def event_invited_memberships?
    memberships.invited.size > 0
  end
end
