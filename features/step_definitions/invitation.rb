Given(/^"([^"]*)" is valid user$/) do |name|
  email_name = name.downcase.gsub(/\s+/, "")
  FactoryGirl.create(:user, email: email_name + "@gmail.com")
end

Given(/^I am logged in$/) do
  visit new_user_session_path
  fill_in 'Email', with: "amberolson@gmail.com"
  fill_in 'Password', with: 'PartyTime1'
  click_button 'Log in'
end

Given(/^I have created an event$/) do
  @event = FactoryGirl.create(:event)
  FactoryGirl.create(:membership)
end

When(/^I go to the Invite Guest page$/) do
  visit new_event_membership_path(@event)
end

Then(/^I see "([^"]*)" within "([^"]*)"$/) do |text, class_name|
    expect(page).to have_css(class_name, text: text)
end

Then(/^Alex should receive an email$/) do
  email = ActionMailer::Base.deliveries.first
  email.from = "from@example.com"
  email.to = "tucker.al@gmail.com"
  email.body = "You have been invited to"
end
