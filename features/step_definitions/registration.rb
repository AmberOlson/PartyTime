When(/^she visits the signup page$/) do
  visit new_user_registration_path
end

When(/^fills in the "([^"]*)" with "([^"]*)"$/) do |arg1, arg2|
  fill_in arg1, with: arg2
end
