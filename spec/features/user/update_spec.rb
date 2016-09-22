require 'rails_helper'

describe 'editing users profile' do

  before do
    login_user
  end

  it 'correctly updates info upon submition' do
    expect(page).to_not have_content('Example User')
    click_link 'Update User Info'
    expect(page).to have_content('Editing Profile')
    fill_in 'Name', with: 'Example User'
    click_button 'Submit'
    expect(page).to have_content('Example User')
  end

  it 'shows error upon error' do
    expect(page).to_not have_content('A')
    click_link 'Update User Info'
    expect(page).to have_content('Editing Profile')
    fill_in 'Name', with: 'A'
    click_button 'Submit'
    expect(page).to have_content('There was a problem editing your user profile.')
  end

end
