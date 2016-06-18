require 'rails_helper'

describe Relationship do
  it {should belong_to(:user)}

  context "when a user invites a person to a part in creates a relationship with that person" do
    it "creates the correct relationship with admin and going status" do
      event = FactoryGirl.create(:event)
      expect(event.title).to eq("Party11")
      user = FactoryGirl.create(:user)
      user_invited = FactoryGirl.create(:user, :email => "example2@email.com")
      relationship = user.createrelationship(user_invited)
      expect(relationship.friend).to eq user_invited.email
    end
  end
end
