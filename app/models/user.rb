class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :memberships, dependent: :destroy
  has_many :relationships, dependent: :destroy
  has_many :events, through: :memberships, dependent: :destroy
  has_many :invited_events, -> { merge(Membership.invited).uniq }, through: :memberships, source: :event
  has_many :going_events, -> { merge(Membership.going).uniq }, through: :memberships, source: :event
  has_many :not_going_events, -> { merge(Membership.notgoing).uniq }, through: :memberships, source: :event

  mount_uploader :picture, PictureUploader
  validates :name, length: { minimum: 2 }, allow_blank: true
  validate  :picture_size

  def has_going_memberships?
    memberships.going.size > 0
  end

  def has_not_going_memberships?
    memberships.notgoing.size > 0
  end

  def has_invited_memberships?
    memberships.invited.size > 0
  end


# this determines if the user has already has a membership associated with a certain event
  def unique(event, user)
    membership = Membership.where("user_id = ? AND event_id = ?", user.id, event.id)
    if membership.count > 0
      false
    else
      true
    end
  end

#creates an initial relationship between and user and an invited friend.
  def createrelationship(user_invited)
    #friendship = Relationship.where("user_id = ? AND friend = ?", self, user_invited.email)
    #if friendship.empty?
      relationship = relationships.create
      relationship.update_attribute(:friend, user_invited.email)
      relationship.save
      return relationship
  #  end
  end

  private

    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end

end
