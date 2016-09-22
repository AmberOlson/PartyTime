class Relationship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  validates_uniqueness_of :user_id, scope: :friend_id

  REL_FAMILY = 'Family'
  REL_OTHER = 'Other'
  REL_FRIEND = 'Friend'
  REL_SCHOOL = 'School'
  REL_COWORKER = 'CoWorker'
  
end
