require 'rails_helper'

describe 'deleting memeberships' do

  before do
    FactoryGirl.create(:event)
    FactoryGirl.create(:membership, admin: false, status: Membership::RSVP_INVITED)

    User.create!(email: 'example@email.com', password: 'password123')
    visit new_user_session_path
    fill_in 'Email', with: 'example@email.com'
    fill_in 'Password', with: 'password123'
    click_button 'Log in'

  end

  it 'removes the person membership and redirects them to their users page' do
    visit '/events/1'
    click_button 'Remove me from list'
    expect(page).to have_content('example@email.com')
    expect(page).to_not have_content('Party11')
  end

end
