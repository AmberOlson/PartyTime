When(/^I go to the signup page$/) do
  visit new_user_registration_path
end

Then(/^I see "([^"]*)"$/) do |msg|
  expect(page).to have_content(msg)
end
