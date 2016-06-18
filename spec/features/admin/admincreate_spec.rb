require "rails_helper"

describe 'adding admin' do

  before do
    login_user
    FactoryGirl.create(:event)
    User.create!(:email => "example2@email.com", :password => "password123", id: 2)
    FactoryGirl.create(:membership, admin: false,   user_id: 2)
  end


  it "successfully add the selected users as an admin" do
    visit '/events/1'
    click_link "Add Admin"
    expect(page).to have_content("Add Admins")
    expect(page).to have_content("example2@email.com")
    find(:css, "#activated_[value='2']").set(true)
    click_button 'Save Admin'
    click_link "Log Out"

    visit new_user_session_path
    fill_in 'Email', :with => "example2@email.com"
    fill_in 'Password', :with => "password123"
    click_button "Log in"

    visit '/events/1'
    click_link "Add Admin"

  end
end
