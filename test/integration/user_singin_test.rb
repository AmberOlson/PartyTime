require 'test_helper'

class UserSinginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "should create new user account" do
    get new_user_registration_path
    post new_user_registration_path, { user_email: "abcd@example.com", user_password: 'password', user_password_confirmation: 'password'  }
    click_button 'Sign up'
    expect(page).to have_content "Welcome! You have signed up successfully."
  end
end
