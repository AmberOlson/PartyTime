require 'rails_helper'

RSpec.describe Event, type: :model do
  it { have_many(:users) }
  it { have_many(:comments) }
  it { have_many(:memberships) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:date) }
  it { should validate_presence_of(:time) }
  it { should validate_length_of(:title).is_at_least(2) }

  xit 'sends an email reminding users of upcoming events' do
    @user = FactoryGirl.create(:user)
    @event = FactoryGirl.create(:event)
    expect { UserMailer.reminder_email(@user, @event).deliver }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

  context 'when a user creats an event' do
    it 'creates the correct relationship with admin and going status' do
      event = FactoryGirl.create(:event)
      expect(event.title).to eq('Party11')
      user = FactoryGirl.create(:user)
      relationship = event.create_admin_membership(user)
      expect(relationship.status).to eq('Going')
      expect(relationship.admin).to eq(true)
    end
  end

end
