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

Then(/^I should see "([^"]*)" within the "([^"]*)" list$/) do |text, class_name|
  expect(page).to have_css("." + class_name + "_membership", text: text)
end

Then(/^"([^"]*)" should receive an email with body "([^"]*)"$/) do |email, body_text|
    email = ActionMailer::Base.deliveries.first
    expect(email.to).to eq(['alextucker@gmail.com'])
    expect(email.body.encoded).to match (body_text)
end
