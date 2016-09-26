require 'rails_helper'

describe Membership do
  it { should belong_to(:event) }
  it { should belong_to(:user) }


  it 'sends an welcome email to new users' do
    @newuser = 'newuser@email.com'
    @event = Event.new(title: 'Party')
    @membership = Membership.new(id: 1)
    expect { UserMailer.welcome_email(@newuser, @event, @membership).deliver }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

  it 'sends an membership email to existing users' do
    @newuser = 'newuser@email.com'
    @event = Event.new(title: 'Party')
    expect { UserMailer.membership_email(@newuser, @event).deliver }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

  context 'when a user invites another user to the event' do
    xit 'correctly update the membership with the invited status and the user_id' do
      FactoryGirl.create(:event)
      membership = FactoryGirl.create(:membership, user_id: nil)
      user = FactoryGirl.create(:user)
      membership.update_membership_attributes(user)
      expect(membership.status).to eq(Membership::RSVP_INVITED)
      expect(membership.user_id).to eq(1)
    end
  end

  context 'when a user invites a person not currently a member' do
    xit 'correctly creates a membership with out a user id and and invited status' do
      event = FactoryGirl.create(:event)
      expect(event.title).to eq('Party11')
      FactoryGirl.create(:user)
      membership = FactoryGirl.create(:membership, user_id: nil, status: nil, event_id: nil)
      membership.new_usermembership
      expect(membership.status).to eq(Membership::RSVP_INVITED)
      expect(membership.user_id).to eq(nil)
    end
  end

end
