Given(/^"([^"]*)" is a logged in user$/) do |name|
  gmail = name.downcase.gsub(/\s+/, "") + "@gmail.com"
  FactoryGirl.create(:user, email: gmail)
  visit new_user_session_path
  fill_in 'Email', with: gmail
  fill_in 'Password', with: 'PartyTime1'
  click_button 'Log in'
end

Given(/^she has an event$/) do
  @event = FactoryGirl.create(:event)
  FactoryGirl.create(:membership)
end

When(/^she visits the Invite Guest page$/) do
  visit '/events/1'
  click_link 'Invite Guest'
end

Given(/^she wants to invite "([^"]*)" a user of the site$/) do |name|
  gmail = name.downcase.gsub(/\s+/, "") + "@gmail.com"
  FactoryGirl.create(:user, email: gmail)
end

When(/^click button "([^"]*)"$/) do |button|
  click_button button
end

When(/^fill in the email with "([^"]*)"$/) do |email|
  fill_in "user_email", with: email
end

Then(/^she will see "([^"]*)"$/) do |msg|
  expect(page).to have_content(msg)
end

Then(/^she will see "([^"]*)" within the "([^"]*)" list$/) do |text, class_name|
  expect(page).to have_css("." + class_name + "_membership", text: text)
end

Then(/^"([^"]*)" should receive an email with body "([^"]*)"$/) do |email, body_text|
    email = ActionMailer::Base.deliveries.first
    expect(email.to).to eq(['alextucker@gmail.com'])
    expect(email.body.encoded).to match (body_text)
end
