When(/^I go to the signup page$/) do
  visit new_user_registration_path
end

Then(/^I should see "([^"]*)"$/) do |msg|
  expect(page).to have_content(msg)
end

 When(/^fill in "([^"]*)" with "([^"]*)"$/) do |arg1, arg2|
     fill_in arg1, with: arg2
end

When(/^click button "([^"]*)"$/) do |button|
  click_button button
end
