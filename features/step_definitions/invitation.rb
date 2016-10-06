Given(/^I am valid user$/) do
  FactoryGirl.create(:user, email: "amberolson@trentu.ca")
end

Given(/^I am logged in$/) do
  visit new_user_session_path
  fill_in 'Email', with: "amberolson@trentu.ca"
  fill_in 'Password', with: 'PartyTime1'
  click_button 'Log in'
end

Given(/^I have created an event$/) do
  @event = FactoryGirl.create(:event)
  FactoryGirl.create(:membership)
end

Given(/^Alex is a valid user$/) do
  FactoryGirl.create(:user, email: "tucker.al@gmail.com")
end


When(/^I go to the Invite Guest page$/) do
  visit new_event_membership_path(@event)
end

Then(/^Alex should receive an email$/) do
  email = ActionMailer::Base.deliveries.first
  email.from = "from@example.com"
  email.to = "tucker.al@gmail.com"
  email.body = "You have been invited to"
end
