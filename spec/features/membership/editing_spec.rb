require "rails_helper"

describe 'editing membership' do

  before do
    FactoryGirl.create(:event)
    FactoryGirl.create(:membership, admin: false, status: Membership::RSVP_INVITED)

    User.create!(:email => "example@email.com", :password => "password123")
    visit new_user_session_path
    fill_in 'Email', :with => "example@email.com"
    fill_in 'Password', :with => "password123"
    click_button "Log in"

  end

  it "changes the status from invited to going" do
    visit "/events/1"
    click_button "Going"
    expect(page).to have_content("You are now attending this event")
  end

end
