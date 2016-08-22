require "rails_helper"

describe 'creating memberships' do

  before do
    FactoryGirl.create(:event)
    FactoryGirl.create(:membership)
    User.create!(:email => "example@email.com", :password => "password123")
    User.create!(:email => "user1@example.com", :password => "password123")
    visit new_user_session_path
    fill_in 'Email', :with => "example@email.com"
    fill_in 'Password', :with => "password123"
    click_button "Log in"
  end

  def invite_user(options ={})
    options[:user_email] ||="user1@example.com"

    visit '/events/1'
    click_link "Invite Guest"
    fill_in :user_email, with: options[:user_email]
    click_button "Invite User"
  end

  it 'redirects to party page after successfully inviting using' do
    invite_user
    expect(page).to have_content("Party11")
    expect(page).to have_content("user1@example.com")
  end

  it "fails and shows an error message when user has already been invited" do
    invite_user
    expect(page).to have_content("Party11")
    expect(page).to have_content("user1@example.com")
    invite_user
    expect(page).to have_content("User already invited")
  end

  it "shows email message when inviting an person that is ot a user yet" do
    invite_user user_email:"user3@example.com"
    expect(page).to have_content("Email Sent")
  end

  it "allows you to invite to invite friends from a previous relationship" do
    FactoryGirl.create(:relationship)
    visit '/events/1'
    click_link "Invite Guest"
    find(:css, "#activated_[value='user1@example.com']").set(true)
    click_button "Invite User"
    expect(page).to have_content("user1@example.com")
  end

  it "selects all friends from a classification" do
    User.create!(:email => "friend1@email.com", :password => "password123")
    User.create!(:email => "friend2@email.com", :password => "password123")
    FactoryGirl.create(:relationship)
    FactoryGirl.create(:relationship, :friend => "friend1@email.com", :classification => Relationship::REL_FRIEND)
    FactoryGirl.create(:relationship, :friend => "friend2@email.com", :classification => Relationship::REL_FRIEND)

    visit '/events/1'
    click_link "Invite Guest"
    within ".classification_friend" do
      click_button "Select All"
      my_box = find("#activated_[value='friend1@email.com']")
      debugger
      #expect(my_box).to be_checked
    end
    click_button "Invite User"
    expect(page).to_not have_content("user1@example.com")
    expect(page).to have_content("friend1@email.com")
    expect(page).to have_content("friend2@email.com")
  end
end
