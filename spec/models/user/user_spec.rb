require 'spec_helper'

describe User do
  it { have_many(:events) }
  it { have_many(:memberships) }
  it { have_many(:relationships) }
  it { have_many(:invited_events) }
  it { have_many(:going_events) }
  it { have_many(:not_going_events) }
  it { should validate_length_of(:name).is_at_least(2) }

  context 'has going memberships' do
    it 'returns true when user has events they are going to' do
      user = FactoryGirl.create(:user)
      FactoryGirl.create(:membership, status: Membership::RSVP_GOING)
      expect(user.has_going_memberships?).to be_truthy
    end

     it 'returns false when there are not going memberships' do
       user = FactoryGirl.create(:user)
       expect(user.has_going_memberships?).to be_falsey
     end
  end

  context 'has not going memberships' do
    it 'returns true when user has events they are going to' do
      user = FactoryGirl.create(:user)
      FactoryGirl.create(:membership, status: Membership::RSVP_NOT_GOING)
      expect(user.has_not_going_memberships?).to be_truthy
    end


    it 'returns false when there are not going memberships' do
      user = FactoryGirl.create(:user)
      expect(user.has_not_going_memberships?).to be_falsey
    end
  end

  context 'has invited memberships' do
    it 'returns true when user has events they are invited to' do
      user = FactoryGirl.create(:user)
      FactoryGirl.create(:membership, status: 'Invited')
      expect(user.has_invited_memberships?).to be_truthy
    end

    it 'returns false when there are not going memberships' do
      user = FactoryGirl.create(:user)
      expect(user.has_invited_memberships?).to be_falsey
    end
  end

  # context 'user has a membership associated with a certain event' do
    # it 'returns true when user has events they are already invited to' do
      # user = FactoryGirl.create(:user)
      # event = FactoryGirl.create(:event)
      # membership = FactoryGirl.create(:membership)
      # expect(user.unique(event, user)).to be_falsey
    # end

    # it 'returns false when user has events they are already invited to' do
      # user = FactoryGirl.create(:user)
      # event = FactoryGirl.create(:event)
      # expect(user.unique(event, user)).to be_truthy
    # end
  # end
end
