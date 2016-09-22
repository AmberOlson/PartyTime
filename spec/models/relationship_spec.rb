require 'rails_helper'

describe Relationship do
  it { should belong_to(:user) }

  context 'when a user invites a person to a party it creates a relationship with that person' do
    it 'creates the correct relationship with admin and going status' do
      event = FactoryGirl.create(:event)
      expect(event.title).to eq('Party11')
      user = FactoryGirl.create(:user)
      user_invited = FactoryGirl.create(:user, email: 'example2@email.com')
      relationship = user.create_relationship(user_invited)
      expect(relationship.friend_id).to eq 2
    end
  end
end
