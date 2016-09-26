require 'rails_helper'

describe 'signing up after an email invite' do

  before do
    FactoryGirl.create(:event)
    FactoryGirl.create(:membership, user_id: nil, admin: false, status:Membership::RSVP_INVITED)
  end

  it 'correctly adds new user to the event' do
    visit welcome_path
    @request.cookies[:membership_id] = 'ABCTOKEN'
    click_link 'Sign up'
  	fill_in 'user_email', with: 'abcd@example.com'
  	fill_in 'user_password', with: 'password'
  	fill_in 'user_password_confirmation', with: 'password'
    click_button 'Sign up'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
    expect(page).to have_content 'Party'
  end

end
